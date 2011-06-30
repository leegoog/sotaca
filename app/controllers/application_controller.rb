class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all # include all helpers, all the time
  
  helper_method :current_cart
  
  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  
  # check if there is a user with language settings, if not use the deault language or the one from the params
  def set_locale
    if session[:user_id]  
      I18n.locale = params[:locale] || User.find(session[:user_id]).locale
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
  
  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.purchased_at
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  
end
