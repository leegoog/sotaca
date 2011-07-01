class ChangePriceToCentsInUser < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :products, :price, :float
  end
end
