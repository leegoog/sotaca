class SetItem < ActiveRecord::Base
  belongs_to :article_set
  belongs_to :product
end
