class AddStockItemIdToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :stock_item_id, :integer
  end

  def self.down
    remove_column :line_items, :stock_item_id
  end
end
