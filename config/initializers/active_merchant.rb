# ONLY for development - remember to turn OFF logging in production

# writes the generated SOAP Requests to log/paypal.log
# ActiveMerchant::Billing::PaypalGateway.logger = Logger.new(STDOUT) 
# ActiveMerchant::Billing::PaypalGateway.wiredump_device = File.new(File.join([Rails.root, "log", "paypal.log"]), "a")