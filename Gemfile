source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'bundler-audit'
gem 'factory_bot_rails'
gem 'faker'
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'kimurai'
gem 'pg'
gem 'puma', '~> 5.6'
gem 'rack-cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
