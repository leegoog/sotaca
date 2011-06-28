class Category < ActiveRecord::Base
    acts_as_nested_set
  
    attr_accessible :name, :description, :lft, :rgt, :parent_id   
    
    has_many :categorizations
    has_many :products, :through => :categorizations
    
end
