class CreateStartImages < ActiveRecord::Migration
  def self.up
    create_table :start_images do |t|
      t.string :link
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :start_images
  end
end
