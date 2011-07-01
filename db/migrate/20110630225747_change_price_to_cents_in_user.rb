class ChangePriceToCentsInUser < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :integer
  end

  def self.down
    change_column :products, :price, :float, :default => 0, :null => false
  end
end
