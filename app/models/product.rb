class Product < ActiveRecord::Base
   
    validates_presence_of :title, :price

    validates :price, :numericality => { :greater_than => 0 }
    
    has_many :categorizations
    has_many :categories, :through => :categorzations
 
    has_many :assets, :dependent => :destroy
    
    has_many :line_items
    

    accepts_nested_attributes_for :assets, :allow_destroy => true
    
end
