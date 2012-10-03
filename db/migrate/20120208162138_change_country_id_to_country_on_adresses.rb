class ChangeCountryIdToCountryOnAdresses < ActiveRecord::Migration
  def self.up
    change_column :adresses, :country_id, :string
    rename_column :adresses, :country_id, :country
  end

  def self.down
    change_column :adresses, :country_id, :integer
    rename_column :adresses, :country, :country_id
  end
end
