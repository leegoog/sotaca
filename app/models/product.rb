class Product < ActiveRecord::Base
    attr_accessible :tile, :description, :price  
   
    validates_presence_of :title, :price
    
    has_many :categories, :through => :categories_products
    has_many :images
    
end
