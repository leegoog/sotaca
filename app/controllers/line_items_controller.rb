class LineItemsController < ApplicationController
   def create
     @product = Product.find(params[:product_id])
     @cart = current_cart
     @stock_item = StockItem.find(params[:stock_item_id])
     @cart.add_item(@product.id, @product.price, @stock_item.id)
     
     respond_to do |format|
       format.html { 
         flash[:notice] = "Added #{@product.title} to cart."
         redirect_to product_path(@product)
         }
       format.js
     end
   end
   
   def destroy
     @line_item = LineItem.find(params[:id])
     @cart = @line_item.cart
     @line_item.destroy
     flash[:notice] = "Removed from cart."
     redirect_to @cart
   end
end
