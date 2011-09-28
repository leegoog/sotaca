# Load the rails application
require File.expand_path('../application', __FILE__)
require 'openssl'



# quickfix ssl error 
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



# force utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8


# default currency
Money.default_currency = Money::Currency.new("GBP")




# redis
ENV["REDISTOGO_URL"] = "redis://sotaca:5a08419c13741bca5336e34605ddafcd@icefish.redistogo.com:9307/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# Initialize the rails application
Sotaca::Application.initialize!
