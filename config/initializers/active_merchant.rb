ActiveMerchant::Billing::PaypalGateway.logger = Logger.new(STDOUT) 
ActiveMerchant::Billing::PaypalGateway.wiredump_device = File.new(File.join([Rails.root, "log", "paypal.log"]), "a")