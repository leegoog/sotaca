class PaymentNotificationsController < ApplicationController  
  skip_before_filter :verify_authenticity_token, :only => [:create] 
  
  # receives IPN (instant payment notification) from paypal and marks the cart with the id = invoice_number as purchased.
  
  def create  
    PaymentNotification.create!(:params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )  
    render :nothing => true  
  end  
end