class AddOrderNrToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_nr, :string
  end

  def self.down
    remove_column :orders, :order_nr
  end
end
