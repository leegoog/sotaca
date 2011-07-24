class OrdersController < ApplicationController
  
  before_filter :authenticate_user!
  
  # lists all orders of a client (if customer) or all orders (if admin)
  
  def index 
    if !current_user.admin?
      @orders = Order.cart.user.orders    
    else
      @orders = Order.all 
    end
  end
  
  # handles paypal xpress checkout
  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents,
      :ip => request.remote_ip,
      :return_url => new_order_url(:order_step => "billing"),
      :cancel_return_url => products_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  # renders the new order template => credit card processing
  def new
    session[:order_params] ||= {}  
    @order = Order.new(session[:order_params])
    @order.express_token = params[:token]
    @order.current_step = session[:order_step]
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  # creates a new order from the current_cart
  def create
    # create order through cart 
    @order = current_cart.build_order(params[:order])
    session[:order_params].deep_merge!(params[:order]) if params[:order]  
    @order = Order.new(session[:order_params])  
    @order.current_step = session[:order_step]  
    if params[:back_button]  
      @order.previous_step  
    elsif @order.last_step?  
      @order.save if @order.all_valid? 
    else  
      @order.next_step  
    end  
    session[:order_step] = @order.current_step  
      
    if @order.new_record?  
      render 'new'  
    else  
      # order is saved and valid
      if @order.purchase
        # order went through gateway successfully
        # reset session information about order
        session[:order_step] = session[:order_params] = nil
        # render :action => "success"
        flash[:notice] = "Order saved."  
        redirect_to @order  
      else
         # gateway didn't authorize or error
         flash[:error] = "There was a problem with the transaction."  
         render :action => "failure"
      end
    end
  end
end
