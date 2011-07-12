class CreateArticleSetLikes < ActiveRecord::Migration
  def self.up
    create_table :article_set_likes do |t|
      t.integer :user_id
      t.integer :article_set_id
      t.timestamps
    end
  end

  def self.down
    drop_table :article_set_likes
  end
end
