class AddStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :integer, :default => 1
  end

  def self.down
    remove_column :orders, :status
  end
end
