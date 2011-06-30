class Order < ActiveRecord::Base
    attr_accessible :cart_id, :ip_address, :first_name, :last_name, :street, :house_nr, :zipcode, :city, :country, :card_type, :card_expires_on, :card_number, :card_verification 
    
    attr_accessor :card_number, :card_verification 
    
    belongs_to :cart
    
    # transactions will be saved to store errors or details from paypal transactions
    has_many :transactions, :class_name => "OrderTransaction"

    # before create check if cc seems valid
    validate_on_create :validate_card

    # the actual transaction after all had been validated
    def purchase
      response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
      transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
      cart.update_attribute(:purchased_at, Time.now) if response.success?
      response.success?
    end

    # price has to be in cents (integer) when communicating with the gateway
    def price_in_cents
      (cart.total_price*100).round
    end

    private

    def purchase_options
      {
        :ip => ip_address,
        :billing_address => {
          :name     => "Ryan Bates",
          :address1 => "123 Main St.",
          :city     => "New York",
          :state    => "NY",
          :country  => "US",
          :zip      => "10001"
        }
      }
    end

    # validate credit_card using activemerchant's built in validation mechanism
    def validate_card
      unless credit_card.valid?
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
