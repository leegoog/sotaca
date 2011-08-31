class Category < ActiveRecord::Base
    acts_as_nested_set
  
    attr_accessible :name, :description, :lft, :rgt, :parent_id   
    
    has_many :categorizations
    has_many :products, :through => :categorizations
    
    attr_accessor :product_list
    
    def product_list
      self_and_ancestors.to_a.collect! { |x| x.products }
    end
      
    
end
