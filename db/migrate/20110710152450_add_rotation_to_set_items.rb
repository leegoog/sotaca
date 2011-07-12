class AddRotationToSetItems < ActiveRecord::Migration
  def self.up
    add_column :set_items, :rotation, :integer
  end

  def self.down
    remove_column :set_items, :rotation
  end
end
