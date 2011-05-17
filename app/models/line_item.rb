class LineItem < ActiveRecord::Base
  
  attr_accessible :product_id, :cart_id, :quantity, :unit_price
  
  attr_accessor :full_price
  
  belongs_to :cart
  belongs_to :product
  
  def full_price
    unit_price * quantity
  end
  
end
