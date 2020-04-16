source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'acts-as-taggable-on', '~> 6.0'
gem 'nokogiri'
gem 'devise'
#gem "cocoon"
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'cancancan'
gem 'chartkick'
gem 'font-awesome-sass', '~> 5.12.0'
gem 'haml-rails', '~> 2.0'
gem 'money-rails', '~>1.12'
gem 'newrelic_rpm'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem "sentry-raven"
gem 'sidekiq', '5.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'stripe'
gem 'webpacker', '~> 4.0'
gem 'whenever', require: false
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'rails_admin', '~> 2.0'
gem 'redis', '~> 4.0'
gem 'redis-rails'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'rspec-rails'
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.4", require: false
  gem 'capistrano3-puma'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rails', require: false
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-rspec', require: false
  gem 'capistrano-local-precompile', '~> 1.2.0', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
