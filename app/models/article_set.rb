class ArticleSet < ActiveRecord::Base
  
    belongs_to :user
    
    has_many :products, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
    accepts_nested_attributes_for :set_items, :allow_destroy => true  
end