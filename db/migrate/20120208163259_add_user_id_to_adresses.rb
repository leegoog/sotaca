class AddUserIdToAdresses < ActiveRecord::Migration
  def self.up
    add_column :adresses, :user_id, :integer
  end

  def self.down
    remove_column :adresses, :user_id
  end
end
