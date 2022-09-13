# frozen_string_literal: true

source "https://rubygems.org"

gemspec
rails_version = (ENV["RAILS_VERSION"] || "7.0.3").to_s

gem "rack-cors"
gem "rake", "~> 13.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# rubocop:disable Bundler/DuplicatedGem
if rails_version == "main"
  git "https://github.com/rails/rails", ref: "main" do
    gem "actionview"
    gem "activemodel"
    gem "activerecord"
    gem "activesupport"
    gem "railties"
  end
else
  gem "actionview", rails_version
  gem "activemodel", rails_version
  gem "activesupport", rails_version
  gem "railties", rails_version
end
# rubocop:enable Bundler/DuplicatedGem

# Use Puma as the app server
gem "puma", "~> 5.6.4"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

gem "view_component", path: ENV["VIEW_COMPONENT_PATH"] if ENV["VIEW_COMPONENT_PATH"]

group :development, :test do
  gem "lookbook", "~> 1.0"
  gem "sprockets-rails"
  gem "sqlite3", "~> 1.4"
  gem "hotwire-livereload", "~> 1.1"
end
