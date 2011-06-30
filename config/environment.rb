# Load the rails application
require File.expand_path('../application', __FILE__)



# quickfix ssl error
require 'openssl' 
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


# force utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# redis
ENV["REDISTOGO_URL"] = "redis://sotaca:5a08419c13741bca5336e34605ddafcd@icefish.redistogo.com:9307/"

# Initialize the rails application
Sotaca::Application.initialize!
