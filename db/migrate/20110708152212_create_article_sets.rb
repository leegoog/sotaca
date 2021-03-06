class CreateArticleSets < ActiveRecord::Migration
  def self.up
    create_table :article_sets do |t|
      t.string :name
      t.integer :user_id, :null => false
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :article_sets
  end
end
