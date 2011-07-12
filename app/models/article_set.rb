class ArticleSet < ActiveRecord::Base
    
    validates_presence_of :name
    validates_length_of :name, :minimum => 3

    # creator
    belongs_to :user
    
    # products m:n
    has_many :products, :through => :set_items
    has_many :set_items, :dependent => :destroy
    
    # users m:n (people liking this set)
    has_many :users, :through => :likes
    has_many :likes, :class_name => 'ArticleSetLike', :dependent => :destroy
    
    # comments
    has_many :comments, :dependent => :destroy 
    
    accepts_nested_attributes_for :set_items, :allow_destroy => true  
end
