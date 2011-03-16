class Image < ActiveRecord::Base
    attr_accessible :title, :product_id  
    
    validates_presence_of :product_id
    
    belongs_to :product
        
end
