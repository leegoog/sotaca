class CreateStockItems < ActiveRecord::Migration
  def self.up
    create_table :stock_items do |t|
      t.integer :product_id
      t.string :color
      t.string :size
      t.integer :amount
      t.timestamps
    end
  end

  def self.down
    drop_table :stock_items
  end
end
