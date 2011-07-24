class CreateArticleSets < ActiveRecord::Migration
  def self.up
    create_table :article_sets do |t|
      t.integer :user_id
      t.string  :name
      t.string :blog_image
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :article_set_likes
  end
end
