class Image < ActiveRecord::Base
    attr_accessible :tile, :product_id  
    
    belongs_to :product
    
end
