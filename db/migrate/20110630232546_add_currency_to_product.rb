class AddCurrencyToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :currency, :string, {:default => 'GBP', :null => :false}
  end

  def self.down
    remove_column :products, :currency
  end
end
