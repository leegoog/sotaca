class Comment < ActiveRecord::Base
    attr_accessible :user_id, :article_set_id, :body
    
    validates_presence_of :body
    
    belongs_to :user 
    belongs_to :article_set
end
