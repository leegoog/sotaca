class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  include SessionsHelper
  
  helper :all # include all helpers, all the time
  
  helper_method :current_cart, :authenticate_superuser!
  
  # before doing anything else in my app, set the locale
  before_filter :set_locale
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end
  

  
  def authenticate_superuser!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_url, :alert => "Permission denied"
    end
    # todo: check for admin flag
  end
  
  # overwrite default url builder to include the locale param
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  # check if there is a user with language settings, if not use the deault language or the one from the params
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    if params[:locale] == 'cn' || params[:locale] == 'us'
      session[:currency] = 'USD'
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
