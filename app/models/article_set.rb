class ArticleSet < ActiveRecord::Base
  
    belongs_to :user
    
    validates_presence_of :name
    validates_length_of :name, :minimum => 3
    
    has_many :products, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
    accepts_nested_attributes_for :set_items, :allow_destroy => true  
end
