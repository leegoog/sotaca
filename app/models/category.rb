class Category < ActiveRecord::Base
    acts_as_nested_set
  
    attr_accessible :name, :description     
    
    has_many :categorizations
    has_many :products, :through => :categorzations
    
end
