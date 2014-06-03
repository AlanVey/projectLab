source 'https://rubygems.org'

# Version details
gem 'rails', '4.1.1'
ruby '2.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# All required for bootstrap
gem 'twitter-bootstrap-rails'
gem 'less-rails'
gem 'therubyracer'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# For user authntication
gem 'devise'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

group :test do
  gem 'capybara'
  gem 'database_cleaner'
end

group :test, :development do 
  gem "factory_girl_rails"
  gem 'rspec-rails'
  # to generate graphical model relationships
  gem 'rails-erd'
end

group :production do
  gem 'rails_12factor'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

