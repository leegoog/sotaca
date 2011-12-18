class CartsController < ApplicationController
  def show
     @cart = current_cart
  end
  
  def destroy
    session[:cart_id] = nil 
    flash[:notice] = "You cart is empty."
    redirect_to root_url
  end
  
end
