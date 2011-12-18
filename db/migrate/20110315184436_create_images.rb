class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :tile
      t.integer :product_id
      t.timestamps
    end
    add_foreign_key(:images, :products, :dependent => :delete)
  end

  def self.down
    drop_table :images
  end
end
