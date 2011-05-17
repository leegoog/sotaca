class LineItemsController < ApplicationController
  def create
     @product = Product.find(params[:product_id])
     @cart = current_cart
     @cart.line_items.create!(:product_id => @product.id, :quantity => 1, :unit_price => @product.price)
     flash[:notice] = "Added #{@product.title} to cart."
     redirect_to current_cart_url
   end
end
