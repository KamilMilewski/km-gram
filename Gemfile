source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
# To user haml formatting instead of standard erb
gem 'haml'
# html/erb to haml converter
gem 'html2haml'
# Simple ImageUpload gem
gem 'paperclip', '~> 5.0.0'
# For simple forms
gem 'simple_form'
# For bootstrap
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
