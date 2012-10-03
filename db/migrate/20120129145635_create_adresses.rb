class CreateAdresses < ActiveRecord::Migration
  def self.up
    create_table :adresses do |t|
      t.string :title
      t.string :name
      t.integer :country_id
      t.string :adress1
      t.string :adress2
      t.string :city
      t.string :county
      t.integer :zip
      t.string :phone1
      t.string :phone2
      t.integer :type 
      t.timestamps
    end
  end

  def self.down
    drop_table :adresses
  end
end
