class AddFirstNameToAdresses < ActiveRecord::Migration
  def self.up
    add_column :adresses, :first_name, :string
    rename_column :adresses, :name, :last_name
  end

  def self.down
    remove_column :adresses, :first_name
    rename_column :adresses, :last_name, :name
  end
end
