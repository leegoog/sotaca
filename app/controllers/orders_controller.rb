class OrdersController < ApplicationController
  
  before_filter :authenticate_user!
  
  #ssl_required :new, :create, :express
  
  # lists all orders of a client (if customer) or all orders (if admin)
  def index 
    if !current_user.admin?
      @orders = current_user.orders.with_cart    
    else
      @orders =Order.with_cart 
    end
  end
  
  # handles paypal xpress checkout
  def express
    price = current_cart.total_price + ShippingMethod.find(session[:order_params]['shipping_method_id']).price
    Rails.logger.debug "price: #{price}"
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents(price),
      :ip => request.remote_ip,
      :return_url => new_order_url(:order_step => "confirmation"),
      :cancel_return_url => products_url,
      :currency => "GBP"
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    Rails.logger.debug response.to_yaml
  end
  
  # renders the new order template => credit card processing
  def new
    # check if anything is in cart, if not redirect
    if current_cart.empty?
      flash[:notice] = "Nothing to checkout!"
      redirect_to products_url
    else
      
      @customer_adress = current_user.adresses.shipping.first
      
      session[:order_params] ||= {}  
      @order = Order.new(session[:order_params])
      @order.express_token = params[:token]
      @order.current_step = params[:order_step] || session[:order_step]
    end
  end
  
  def show
    if !current_user.admin? # only admin can see all orders
      @order = current_user.orders.find(params[:id])
    else
      @order = Order.find(params[:id])
    end
  end
  
  # creates a new order from the current_cart
  def create
    @customer_adress = current_user.adresses.shipping.first
    # create order through cart 
    @order = current_cart.build_order(params[:order])
    
    session[:order_params].deep_merge!(params[:order]) if params[:order]  
    @order = Order.new(session[:order_params])  
    @order.current_step = session[:order_step]  
    @order.ip_address = request.remote_ip
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
      # try to transfer the money
      if @order.purchase
        # send confirmation email
        
        # TODO - put emails into background job
        @order.save_adress  
        OrderMailer.order_confirmation(@order).deliver 
        # reset session information about order
        session[:order_step] = session[:order_params] = nil
        # order went through gateway successfully
        # render :action => "success"
        flash[:notice] = "Order saved."  
        redirect_to @order  
      else
         # gateway didn't authorize or error
         flash[:error] = "There was a problem with the transaction."  
         render :action => "failure"
         # delete??
         # @order.destroy
      end
    end
  end
end
