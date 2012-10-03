class StockItem < ActiveRecord::Base
    attr_accessible :product_id, :color, :size, :amount
    
    belongs_to :product, :dependent => :destroy
    
    validates_presence_of :product_id, :amount
    
    validates_numericality_of :amount
    
    has_many :line_items
    
end
