class AddUrlToSetItems < ActiveRecord::Migration
  def self.up
    add_column :set_items, :url, :string
  end

  def self.down
    remove_column :set_items, :url
  end
end
