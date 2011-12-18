class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_set_id
      t.text :body
      t.timestamps
    end
    add_foreign_key(:comments, :article_sets, :dependent => :delete)
    add_foreign_key(:comments, :users, :dependent => :delete)
  end

  def self.down
    drop_table :comments
  end
end
