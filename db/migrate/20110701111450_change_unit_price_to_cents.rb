class ChangeUnitPriceToCents < ActiveRecord::Migration
  def self.up
    change_column :line_items, :unit_price, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :line_items, :unit_price, :float
  end
end
