class AddBlogImageToArticleSets < ActiveRecord::Migration
  def self.up
    add_column :article_sets, :blog_image, :string
  end

  def self.down
    remove_column :article_sets, :blog_image
  end
end
