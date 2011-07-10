class ChangeSetItemFieldsToStrings < ActiveRecord::Migration
  def self.up
     change_column :set_items, :pos_x, :string
     change_column :set_items, :pos_y, :string
     change_column :set_items, :width, :string
     change_column :set_items, :height, :string
     change_column :set_items, :z_index, :string
  end

  def self.down
    change_column :set_items, :pos_x, :integer
    change_column :set_items, :pos_y, :integer
    change_column :set_items, :width, :integer
    change_column :set_items, :height, :integer
    change_column :set_items, :z_index, :integer
  end
end
