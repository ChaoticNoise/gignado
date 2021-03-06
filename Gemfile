source 'https://rubygems.org'
ruby "2.6.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '0.21.0'
gem 'rails_12factor', group: :production
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'bootstrap-sass', '~> 3.3'

gem 'font-awesome-rails', '~> 4.6'
# navigation
gem 'simple-navigation', '~> 4.0.3'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# use forked http-cookie to preserve gig-o-matic double-quotes in cookie values
gem 'http-cookie', git: 'https://github.com/breadbeard/http-cookie.git', ref: 'ba63c233036389087edc49c0c1293744e1919ae1'
# Used for interacting with gig-o-matic via it's UI
gem 'mechanize', '~> 2.7.4'

gem 'puma'

# Authentication
gem 'devise', '~> 4.6.2'
gem 'omniauth-google-oauth2', '~> 0.7.0'

# Calendar
gem 'icalendar', '~> 2.0'

# Test Coverage analysis tool. Used for Codacy metrics
gem 'simplecov', require: false, group: :test
gem 'codacy-coverage', require: false

# Async jobs
gem 'sucker_punch', '~> 2.0'
gem 'active_job_status', git: 'https://github.com/cdale77/active_job_status.git', ref: 'f61a2c77dba10bd8b763f2cef7e1ef54cc4746b5'

# Form Gems
gem 'reform', '>= 2.2.0'
gem 'reform-rails'
gem 'dry-validation', '~> 0.11.0'
gem 'dry-types', '~> 0.11.1'
gem 'simple_form', '~> 4.1.0'
gem 'timezone', '~> 1.0'
gem 'tinymce-rails', '~> 4.6.6'

# Cache
gem 'dalli', '~> 2.7.6'
gem 'memcachier'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'minitest', '~> 5.8'

  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  # Auto handle events on filesystem modifications
  gem 'guard', '~> 2.13'
  gem 'guard-minitest', '~> 2.4'
  gem 'guard-livereload', '~> 2.4'
  gem 'minitest-reporters', '~> 1.1'
  gem 'rack-livereload'

  # Test data
  gem "faker", "~> 1.5"
  gem "factory_girl_rails", "~> 4.0"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
