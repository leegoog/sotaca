class CreateSetItems < ActiveRecord::Migration
  def self.up
    drop_table :set_items
    
    create_table :set_items do |t|
      t.integer :set_id
      t.integer :product_id
      t.integer :pos_x
      t.integer :pos_y
      t.integer :width
      t.integer :height
      t.integer :z_index

      t.timestamps
    end
  end

  def self.down
    drop_table :set_items
  end
end
