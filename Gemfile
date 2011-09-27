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
gem 'rmagick', :require => false

gem 'activeadmin'

# layout stuff
gem 'jquery-rails'
gem 'nested_form'
gem 'simple_form'
gem 'client_side_validations'
gem 'rails3-jquery-autocomplete'
gem 'awesome_nested_set'
gem 'simple_form'
gem 'redcarpet'  # markdown interpreter

### internationalization
# key-value store
gem 'i18n', :git => "git://github.com/svenfuchs/i18n.git", :ref => "8ad0f4b65406e380becbf4c553f1919f15029ddd"
gem 'globalize3'
gem 'redis'
gem 'money'
gem 'google_currency'

# console stuff
gem 'hirb'


# payment, credit card processing
gem 'activemerchant'

# add foreign keys to sql databases
gem 'foreigner'

# ssl middleware
gem 'rack-ssl'

# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development do
  gem 'nifty-generators'
  gem 'rspec-rails', '2.6.1'
  gem 'autotest-rails'
end

group :test do    
  gem 'rspec-rails', '2.6.1'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'capybara'   
  gem 'factory_girl_rails'
  gem 'autotest-rails'
  gem 'ZenTest'
  gem 'spork', '~> 0.9.0.rc8'
  gem "mocha"
end
