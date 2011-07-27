class LineItemsController < ApplicationController
   def create
     @product = Product.find(params[:product_id])
     @cart = current_cart
     @cart.add_item(@product.id, @product.price)
     flash[:notice] = "Added #{@product.title} to cart."
     redirect_to current_cart_url
   end
   
   def destroy
     @line_item = LineItem.find(params[:id])
     @cart = @line_item.cart
     @line_item.destroy
     flash[:notice] = "Removed from cart."
     redirect_to @cart
   end
end
