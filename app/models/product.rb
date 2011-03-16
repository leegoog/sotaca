class Product < ActiveRecord::Base
    attr_accessible :title, :description, :price  
   
    validates_presence_of :title, :price
    
    has_many :categories, :through => :categories_products
    has_many :images, :dependent => :destroy

    accepts_nested_attributes_for :images
    
end
