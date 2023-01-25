source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem 'aws-sdk-rails'
gem 'fog-aws'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'rmagick'
gem 'rubocop', require: false
gem 'pundit'
gem 'dotenv-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "ed25519"
  gem "bcrypt_pbkdf"
end

group :production do
  gem "pg"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
