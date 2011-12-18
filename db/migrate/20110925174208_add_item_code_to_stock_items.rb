class AddItemCodeToStockItems < ActiveRecord::Migration
  def self.up
    add_column :stock_items, :item_code, :string
  end

  def self.down
    remove_column :stock_items, :item_code
  end
end
