class ChangeSetIdToArticleSetId < ActiveRecord::Migration
  def self.up
    rename_column :set_items, :set_id, :article_set_id
  end

  def self.down
    rename_column :set_items, :article_set_id, :set_id
  end
end
