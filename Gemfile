source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


# SPECIAL GEMS FOR THIS SERVICE =========================================================================
gem 'geocoder' #use geocoder for geospatial processing and mapping
gem 'json'

# SPECIAL GEMS FOR FRONT-FACING INTERFACE
gem 'compass-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'slim-rails'
gem 'gon'
gem 'kaminari'
gem 'devise'
#gem 'devise'
#gem 'clearance'

group :development, :test do
  gem 'sqlite3' # use sqlite3 during development and testing
  gem 'rspec-rails', '~> 3.0.0' # use RSpec as the testing framework
end

group :production do
  gem 'rails_12factor' #Heroku's gem for Rails deployments
  gem 'pg' #Postgresql
  #gem 'aws-sdk' #Assists with Amazon S3 integration
end

group :test do
  #gem 'capybara' #Allows integration tests to simulate user interactions, like clicking or filling out forms
  gem 'factory_girl_rails' #Creates factories for testing
end

