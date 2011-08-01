class Order < ActiveRecord::Base
    attr_accessible :cart_id, :ip_address, :first_name, :last_name, :street, :house_nr, :zipcode, :city, :country, :order_nr
    attr_accessible :shipping_method_id, :user_id, :card_type, :card_expires_on, :card_number, :card_verification, :express_token
    
    attr_accessor :card_number, :card_verification, :order_number
    
    attr_writer :current_step
    
    belongs_to :cart
    belongs_to :user
    
    # shipping method
    belongs_to :shipping_method
    
    
    # transactions will be saved to store errors or details from paypal transactions
    has_many :transactions, :class_name => "OrderTransaction"

    # before create check if cc seems valid
    validate :validate_card, :on => :create
    
    validates_presence_of :first_name, :last_name, :street, :zipcode, :city, :country, :if => :shipping?
    
    # validate CC data only if there is no paypal token - no need to enter when paying with paypal, right
    validates_presence_of :card_number, :card_verification, :card_expires_on, :if => :billing? 
    
    
#    validates_presence_of :billing_name, :if => lambda { |o| o.current_step == "billing" }

    # the actual transaction after all had been validated
    def purchase
      response = process_purchase
      transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
      if response.success?
        cart.update_attribute(:purchased_at, Time.now) 
        self.update_attributes(:order_nr => self.order_number)
        Rails.logger.debug "Order nr. generated: #{self.order_number}"
      else # response failed
        Rails.logger.debug "response_params: #{response.params.to_yaml}"
      end
      response.success?
    end

    def express_token
      self[:express_token]
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
  
    

    # returns the price of all cart items and shipping costs for this order in cents (integer) for communicating with the gateway
    def price_in_cents(money=nil)
      if money
        money.to_money.cents.to_i
      else
        cart.total_price.to_money.cents.to_i + shipping_method.price.to_money.cents.to_i
      end
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
    
    # returns true if current step is shipping
    def shipping?  
      current_step == "shipping"  
    end  
    # returns true if current step is billing
    def billing?  
      current_step == "billing" && express_token.blank?
    end
    # returns true if current step is billing
    def confirmation?  
      current_step == "confirmation"  
    end    
    
    # goes through all steps and validates them
    def all_valid?  
      steps.all? do |step|  
        self.current_step = step  
        valid?  
      end  
    end

    # create an unique identifier 'order_number'
    def order_number
      "#{self.id}-#{Time.now.to_i.to_s[-4..-1]}-#{rand(1_000)}"
    end
    
    
    # calculates the total price of the order from all items and shipping
    def total_price
      self.cart.total_price + self.shipping_method.price
    end

    private

      

    # collect order information to send to gateway for payment processing
    def standard_purchase_options
      values =  {
        :ip => "216.113.168.139", # test
        :currency => "GBP",
        :invoice => order_number,
        :billing_address => {
          :name     => "#{first_name} #{last_name}",
          :address1 => "#{street} #{house_nr}",
          :city     => city,
          :country  => country,
          :zip      => zipcode
        }
      }
      # merge all line items from cart into values
       cart.line_items.each_with_index do |item, index|
         values.merge!({
           "amount_#{index+1}" => item.unit_price.cents,
           "item_name_#{index+1}" => item.product.title,
           "item_number_#{index+1}" => item.id,
           "quantity_#{index+1}" => item.quantity
         })
      end
      values  # return values
    end
    
    # gather information fpr express purchase
    def express_purchase_options
      {
        :ip => ip_address,
        :token => express_token,
        :payer_id => express_payer_id,
        :cart_type => nil,
        :currency => "GBP",
        :currency_id => "GBP"
      }
    end
    
    # process purchase through different gateway depending on payment method
    def process_purchase
      if express_token.blank?
        #STANDARD_GATEWAY.wiredump_device = STDOUT
        Rails.logger.debug "contacting credit card gateway..."
        Rails.logger.debug "price in cents: #{price_in_cents}, options:\n #{standard_purchase_options.to_yaml}"
        STANDARD_GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
      else
        Rails.logger.debug "contacting paypal express gateway..."
        Rails.logger.debug "price in cents: #{price_in_cents}, options:\n #{express_purchase_options.to_yaml}"
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
