class CreateProductLikes < ActiveRecord::Migration
  def self.up
    create_table :product_likes do |t|
      t.integer :user_id
      t.integer :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :product_likes
  end
end
