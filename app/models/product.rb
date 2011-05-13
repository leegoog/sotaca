class Product < ActiveRecord::Base
   
    validates_presence_of :title, :price
    
    has_many :categories, :through => :categories_products
    has_many :assets, :dependent => :destroy

    accepts_nested_attributes_for :assets, :allow_destroy => true
    
end
