class RenameTypeOnAdresses < ActiveRecord::Migration
  def self.up
    rename_column :adresses, :type, :adress_type
  end

  def self.down
        rename_column :adresses, :adress_type, :type
  end
end
