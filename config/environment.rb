# Load the rails application
require File.expand_path('../application', __FILE__)



# quickfix ssl error
require 'openssl' 
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Initialize the rails application
Sotaca::Application.initialize!
