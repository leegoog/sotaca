class ShippingMethod < ActiveRecord::Base
    attr_accessible :name, :price
    
    attr_accessor :name_and_price 
    
    has_many :orders
    
    composed_of :price,
                  :class_name => 'Money',
                  :mapping => %w(price cents),
                  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
                  
    
    def name_and_price
      "#{self.name} (#{self.price.format(:symbol => true)})"
    end
    
    
end
