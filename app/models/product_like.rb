class ProductLike < ActiveRecord::Base
    attr_accessible :user_id, :product_id, :created_at
    
    validates_presence_of :user_id
    
    belongs_to :user
    belongs_to :product
    
    validates_uniqueness_of :user_id, :scope => :product_id
    
end
