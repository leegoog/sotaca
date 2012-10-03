class ChangeStreetToAdressOnOrders < ActiveRecord::Migration
  def self.up
    rename_column :orders, :street, :adress1
    change_column :orders, :house_nr, :string
    rename_column :orders, :house_nr, :adress2
  end

  def self.down
    rename_column :orders, :adress1, :street
    change_column :orders, :house_nr, :integer
    rename_column :orders, :adress2, :house_nr
  end
end
