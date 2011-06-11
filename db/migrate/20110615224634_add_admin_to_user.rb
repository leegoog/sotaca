class AddAdminToUser < ActiveRecord::Migration
  # changed date
  def self.up
    add_column :users, :admin, :boolean
  end

  def self.down
    remove_column :users, :admin
  end
end
