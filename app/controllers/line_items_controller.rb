class LineItemsController < ApplicationController
  def create
     @product = Product.find(params[:product_id])
     @cart = current_cart
     @cart.add_item(@product.id, @product.price)
     flash[:notice] = "Added #{@product.title} to cart."
     redirect_to current_cart_url
   end
end
