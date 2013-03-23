class ChangeTableAdresses < ActiveRecord::Migration
  def self.up
    change_column :adresses, :zip, :string
  end

  def self.down
    change_column :adresses, :zip, :integer
  end
end
