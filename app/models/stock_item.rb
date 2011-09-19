class StockItem < ActiveRecord::Base
    attr_accessible :product_id, :color, :size, :amount
    
    belongs_to :product
    
end
