class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :tile
      t.integer :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
