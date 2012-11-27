class StockItem < ActiveRecord::Base
    attr_accessible :product_id, :color, :size, :amount
    
    belongs_to :product
    
    validates_presence_of :product_id, :amount
    
    validates_numericality_of :amount
    
    has_many :line_items
    
    
    def reduce_quantity
      self.amount -= 1
      self.save!
    end
    
end
