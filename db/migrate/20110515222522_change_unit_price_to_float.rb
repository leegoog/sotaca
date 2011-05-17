class ChangeUnitPriceToFloat < ActiveRecord::Migration
  def self.up
    change_table :line_items do |t|
      t.change :unit_price, :float
    end
  end

  def self.down
    change_table :line_items do |t|
      t.change :unit_price, :decimal
    end
  end
end
