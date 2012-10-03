class AddActiveIdToAdresses < ActiveRecord::Migration
  def self.up
    add_column :adresses, :active, :boolean, :default => false
  end

  def self.down
    remove_column :adresses, :active
  end
end
