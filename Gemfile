source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'interactor-rails'

gem 'render_pipeline', github: 'ello/render_pipeline', ref: '62483f8'

gem 'rack-timeout'
gem 'newrelic_rpm'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor'
end
