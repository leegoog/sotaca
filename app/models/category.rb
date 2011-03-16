class Category < ActiveRecord::Base
    attr_accessible :name, :description     
    
    has_many :products, :through => :categories_products
    
end
