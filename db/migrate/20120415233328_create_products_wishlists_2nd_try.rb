class CreateProductsWishlists2ndTry < ActiveRecord::Migration

  def self.up
    create_table :products_wishlists, :id => false do |t|
       t.references :product
       t.references :wishlist
    end
  end


  def self.down
    drop_table :products_wishlists
  end
end
