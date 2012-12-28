Sotaca::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  config.action_mailer.default_url_options = { :host => 'sotaca.dev' }


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.perform_deliveries    = true
  
  config.log_level = :debug
  

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  config.after_initialize do
   ActiveMerchant::Billing::Base.mode = :test # :production
   # paypal credentials as hash
   paypal_options = {
     :login => "tmaxim_1353583741_biz_api1.gmail.com",
     :password => "1353583810",
     :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AuFHlWIFdTBe5D.OUM41TxF5wLLb"
    }
    ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'GBP'  
    ActiveMerchant::Billing::PaypalGateway.default_currency = 'GBP'  
    
    ActiveMerchant::Billing::PaypalGateway.logger = Logger.new(STDOUT) 
    ActiveMerchant::Billing::PaypalGateway.wiredump_device = File.open("#{Rails.root}/log/paypal.log", "a+")
    ActiveMerchant::Billing::PaypalGateway.wiredump_device.sync = true    
    # standard gateway
    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    # gateway for paypal express checkout
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
    
    
    ### BULLET ###
    
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.growl = false
    Bullet.rails_logger = true
    Bullet.airbrake = false
    Bullet.disable_browser_cache = true
    
    
  end
  
end

