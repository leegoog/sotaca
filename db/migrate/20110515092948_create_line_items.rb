class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.decimal :unit_price
      t.integer :product_id
      t.integer :cart_id
      t.integer :quantity

      t.timestamps
    end
    add_foreign_key(:line_items, :carts, :dependent => :delete)
  end

  def self.down
    drop_table :line_items
  end
end
