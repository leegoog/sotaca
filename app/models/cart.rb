class Cart < ActiveRecord::Base
    attr_accessible :id, :purchased_at, :line_items
    
    has_many :line_items, :dependent => :destroy
    
    attr_accessor :total_price, :full_price
    
    def total_price
      line_items.to_a.sum { |item| item.full_price }
    end
    
    
end
