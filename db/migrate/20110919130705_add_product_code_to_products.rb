class AddProductCodeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :product_code, :string
  end

  def self.down
    remove_column :products, :product_code
  end
end
