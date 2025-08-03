# A sample Gemfile
source "https://rubygems.org"

ruby "2.3.1"

gem "sinatra", "~> 2", require: "sinatra/base"
gem "sinatra-contrib", "~> 2"
gem "rake", "~> 10.5.0"
gem "rack-protection"
gem "rack-contrib"

# Utils
gem "slim"
gem "tux"
gem "dotenv"
gem "envied"
gem "json"
gem "dragonfly", "~> 1.0.12"
gem "jwt"
gem "mailgun-ruby", "1.1.0", require: "mailgun"
gem "slugify", "1.0.6"

# Database
gem "sequel", "~> 4.26.0"
gem "sinatra-sequel", "~> 0.9.0"
gem "pg", "~> 0.18.3"

group :development, :test do
  gem "thin"
  gem "shotgun"
  gem "pry", require: "pry"
  gem "capistrano", "~>3.11", require: false
  gem "capistrano-rbenv", "~>2.1"
end

group :test do
  gem "minitest"
  gem "simplecov", require: false
end
