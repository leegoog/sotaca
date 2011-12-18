class RemoveTileFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :tile
  end

  def self.down
    add_column :products, :tile, :string
  end
end
