# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in view-component-ui.gemspec.
gemspec

gem 'sqlite3'

gem 'sprockets-rails'

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

gem 'lookbook'

gem 'webrick', '~> 1.7'
gem 'puma', '~> 6.3'
gem 'parser'
gem 'listen'
gem 'deep_merge'

group :development, :test do
  gem 'foreman'
  gem 'pry', '>= 0.12.2'
  gem 'rspec-rails', '>= 6.0.0'
  gem 'rspec-snapshot'
  gem 'rubocop', '>= 1.56.0'
  gem 'rubocop-performance', '>= 1.18.0'
  gem 'rubocop-rails', '>= 2.20.2'
  gem 'rubocop-rspec', '>= 2.23.2'
end
