class OrderStatusesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @order_statuses = OrderStatus.all
  end

  def show
    @order_status = OrderStatus.find(params[:id])
  end

  def new
    @order_status = OrderStatus.new
  end

  def create
    @order_status = OrderStatus.new(params[:order_status])
    if @order_status.save
      flash[:notice] = "Successfully created order status."
      redirect_to @order_status
    else
      render :action => 'new'
    end
  end

  def edit
    @order_status = OrderStatus.find(params[:id])
  end

  def update
    @order_status = OrderStatus.find(params[:id])
    if @order_status.update_attributes(params[:order_status])
      flash[:notice] = "Successfully updated order status."
      redirect_to order_status_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order_status = OrderStatus.find(params[:id])
    @order_status.destroy
    flash[:notice] = "Successfully destroyed order status."
    redirect_to order_statuses_url
  end
end
