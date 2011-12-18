class AddImgToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :img, :string
  end

  def self.down
    remove_column :images, :img
  end
end
