class AddCounterCachesToArticleSets < ActiveRecord::Migration
  def self.up
    add_column :article_sets, :comments_count, :integer, :default => 0
    add_column :article_sets, :likes_count, :integer, :default => 0
    
    ArticleSet.reset_column_information

    ArticleSet.find_each do |a|
      ArticleSet.reset_counters a.id, :comments
      ArticleSet.reset_counters a.id, :likes      
    end 
  end

  def self.down
    remove_column :article_sets, :likes_count
    remove_column :article_sets, :comments_count
  end
end
