source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'


# authhorization
gem 'devise'
gem 'bcrypt-ruby', :require => "bcrypt" 
gem 'cancan'  

# database
gem 'mysql'

# pagination
gem 'kaminari'

# image upload & processing
gem 'fog' # -> s3 cloud
gem 'carrierwave'
gem 'rmagick'

# layout stuff
gem 'jquery-rails'
gem 'nested_form'
gem 'simple_form'
gem 'client_side_validations'
gem 'awesome_nested_set'

# internationalization key-value store
gem 'redis'

# payment, credit card processing
gem 'activemerchant'

# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development do
  gem 'nifty-generators'
  gem 'rspec-rails', '2.5.0'
  gem 'cucumber-rails'
  gem 'capybara'   
end

group :test do    
  gem 'rspec', '2.5.0'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'capybara'   
  gem 'factory_girl'
end


