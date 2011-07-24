class Order < ActiveRecord::Base
    attr_accessible :cart_id, :ip_adress, :first_name, :last_name, :street, :house_nr, :zipcode, :city, :country, :card_type, :card_expires_on, :card_number, :card_verification, :express_token 
    
    attr_accessor :card_number, :card_verification
    
    attr_writer :current_step  

    
    belongs_to :cart
    
    # transactions will be saved to store errors or details from paypal transactions
    has_many :transactions, :class_name => "OrderTransaction"

    # before create check if cc seems valid
    validate :validate_card, :on => :create
    
    # validates_presence_of :shipping_name, :if => lambda { |o| o.current_step == "shipping" }  
    # validates_presence_of :billing_name, :if => lambda { |o| o.current_step == "billing" }

    # the actual transaction after all had been validated
    def purchase
      response = process_purchase
      transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
      cart.update_attribute(:purchased_at, Time.now) if response.success?
      response.success?
    end

    def express_token=(token)
      self[:express_token] = token
      if new_record? && !token.blank?
        details = EXPRESS_GATEWAY.details_for(token)
        self.express_payer_id = details.payer_id
        self.first_name = details.params["first_name"]
        self.last_name = details.params["last_name"]
      end
    end
    
    def process_purchase
      if condition
        STANDARD_GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
      else
        EXPRESS_GATEWAY.purchase(price_in_cents, credit_card, express_purchase_options)
      end    
    end

    # price has to be in cents (integer) when communicating with the gateway
    def price_in_cents
      cart.total_price.to_money.cents.to_i
    end
    
    # returns an array of our checkout form steps
    def steps  
      %w[shipping billing confirmation]  
    end
    
    # returns the current step
    def current_step  
      @current_step || steps.first  
    end    
    
    # returns the next element from steps array
    def next_step  
      self.current_step = steps[steps.index(current_step)+1]  
    end

    # returns previous element from steps array
    def previous_step  
      self.current_step = steps[steps.index(current_step)-1]  
    end
    
    # checks if we are on the last step
    def last_step?  
      current_step == steps.last  
    end
    
    # checks if we are on the first step
    def first_step?  
      current_step == steps.first  
    end
    
    # goes through all steps and validates them
    def all_valid?  
      steps.all? do |step|  
        self.current_step = step  
        valid?  
      end  
    end

    private

    # dummy methods to be replaced by real values
    def standard_purchase_options
      {
        :ip => ip_address,
        :billing_address => {
          :name     => "#{first_name} #{last_name}",
          :address1 => "#{street} #{house_nr}",
          :city     => city,
          :country  => country,
          :zip      => zipcode
        }
      }
    end
    
    # gather information fpr express purchase
    def express_purchase_options
      {
        :ip => ip_address,
        :token => express_token,
        :payer_id => express_payer_id,
        :cart_type => nil
      }
    end
    
    # process purchase through different gateway depending on payment method
    def process_purchase
      if express_token.blank?
        STANDARD_GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
      else
        EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
      end
    end

    
    # validate credit_card using activemerchant's built in validation mechanism
    def validate_card
      if express_token.blank? && !credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          # adding each error message from active merchant to our error messages of the order model
          errors.add_to_base message
        end
      end
    end

    # credit card getter / setter
    def credit_card
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :type               => card_type,
        :number             => card_number,
        :verification_value => card_verification,
        :month              => card_expires_on.month,
        :year               => card_expires_on.year,
        :first_name         => first_name,
        :last_name          => last_name
      )
    end
    
end
