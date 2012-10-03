class Category < ActiveRecord::Base
    acts_as_nested_set
    
    translates :name, :fallbacks_for_empty_translations => true
    accepts_nested_attributes_for :translations
  
    #attr_accessible :name, :description, :lft, :rgt, :parent_id   
    
   # has_many :categorizations
    has_many :products #, :through => :categorizations
    
    def branch_ids
      self_and_descendants.map(&:id).uniq 
    end
    

    def all_products
       Category.find(branch_ids, :include => :products).map(&:products).flatten!.uniq
    end
    
    
end
