class Comment < ActiveRecord::Base
    attr_accessible :user_id, :article_set_id, :body
end
