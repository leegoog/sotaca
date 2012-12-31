class LineItem < ActiveRecord::Base
  
  attr_accessible :stock_item_id, :product_id, :cart_id, :quantity, :unit_price
  
  attr_accessor :full_price, :increase
  
  belongs_to :product
  belongs_to :cart
  belongs_to :stock_item
  
  
  # returns the total price of this line item (quantity * price)
  def full_price
    unit_price * quantity
  end
  
  # increases the quantity by one
  def increase
    self.quantity += 1
  end
  
  
  # the unit_price is dynamically mapped to an Money object (unit_price is in GBP cents integer)
  # 
  composed_of :unit_price,
                :class_name => 'Money',
                # map unit_price to Money.new.cents
                :mapping => %w(unit_price cents),
                # if the unit_price value responds to the 'to_money' method, which it should, its initialized
                # else we get an empty Money object
                :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
  
end
