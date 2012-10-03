class ChangeTypeOnAdresses < ActiveRecord::Migration
  def self.up
    change_column :adresses, :type, :string
  end

  def self.down
    change_column :adresses, :type, :integer
  end
end
