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
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.perform_deliveries    = true
  

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
      :login => "seller_1309468633_biz_api1.sotaca1898.com",
      :password => "1309468677",
      :signature => "A2TmxPHrKbxkYzrV0vR-LLSlaaL7A3nJ6XG47NViW-7kPA5zro5L-vSX "
    )
  end
  
  
end

