class Wishlist < ActiveRecord::Base
    attr_accessible :user_id, :product_ids
    
    validates_presence_of :user_id
    
    belongs_to :user
    
    has_and_belongs_to_many :products, :uniq => true
    
    
end
