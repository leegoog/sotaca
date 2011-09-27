class Category < ActiveRecord::Base
    acts_as_nested_set
  
    attr_accessible :name, :description, :lft, :rgt, :parent_id   
    
   # has_many :categorizations
    has_many :products #, :through => :categorizations
    
    attr_accessor :product_list
    
    def branch_ids
      self_and_descendants.map(&:id).uniq 
    end
    

    def all_products
       Category.find(branch_ids, :include => :products).map(&:products).flatten!.uniq
    end
    
    
end
