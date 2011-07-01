class LineItem < ActiveRecord::Base
  
  attr_accessible :product_id, :cart_id, :quantity, :unit_price
  
  attr_accessor :full_price, :increase
  
  belongs_to :cart
  belongs_to :product
  
  def full_price
    unit_price * quantity
  end
  
  def increase
    self.quantity += 1
  end
  
  composed_of :unit_price,
                :class_name => 'Money',
                :mapping => %w(unit_price cents),
                :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }
  
end
