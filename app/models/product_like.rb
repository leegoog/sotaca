class ProductLike < ActiveRecord::Base
    attr_accessible :user_id, :product_id, :created_at
    
    belongs_to :user
    belongs_to :product
    
end
