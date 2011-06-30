class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  # creates a new order from the current_cart
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        # order was valid and could be purchased
        render :action => "success"
      else
        # order seemed valid but could not be purchased through gateway
        render :action => "failure"        
      end
    else
      render :action => 'new'
    end
  end
end
