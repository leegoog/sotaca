class ArticleSetLike < ActiveRecord::Base
    attr_accessible :user_id, :article_set_id
    
     validates_presence_of :user_id
     validates_presence_of :article_set_id

     belongs_to :user
     belongs_to :article_set
     
     validates_uniqueness_of :user_id, :scope => :article_set_id
    
end
