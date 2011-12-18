class AddSubtitleToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :subtitle, :string
  end

  def self.down
    remove_column :products, :subtitle
  end
end
