class AddLegacyToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :legacy, :boolean, :default => false
  end

  def self.down
    remove_column :products, :legacy
  end
end
