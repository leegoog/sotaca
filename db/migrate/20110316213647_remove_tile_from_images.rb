class RemoveTileFromImages < ActiveRecord::Migration
  def self.up
    remove_column :images, :tile
  end

  def self.down
    add_column :images, :tile, :string
  end
end
