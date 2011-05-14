class AddPasswordSaltToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_salt, :string
    add_column :users, :password_hash, :string
  end

  def self.down
    remove_column :users, :password_salt
    remove_column :users, :password_hash
  end
end
