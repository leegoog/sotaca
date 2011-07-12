class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all # include all helpers, all the time
  
  helper_method :current_cart
  
  # before doing anything else in my app, set the locale
  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  
  # overwrite default url builder to include the locale param
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  # check if there is a user with language settings, if not use the deault language or the one from the params
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    if params[:locale] == 'cn'
      session[:currency] = 'CNY'
    elsif params[:locale] == 'eu'
      session[:currency] = 'EUR'
    else
      session[:currency] = 'GBP'
    end          
  end
  
  
  # returns the current cart object or creates a new one
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
