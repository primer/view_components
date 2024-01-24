# frozen_string_literal: true

source "https://rubygems.org"

gemspec
rails_version = (ENV["RAILS_VERSION"] || "7.1.1").to_s

# remove when https://github.com/rails/rails/pull/47142 is merged
gem "rack", "~> 2.2"

gem "rack-cors"
gem "rake", "~> 13.1"

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
gem "puma", "~> 6.4.2"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

gem "lookbook", "~> 2.1.1" unless rails_version.to_f < 7
gem "view_component", path: ENV["VIEW_COMPONENT_PATH"] if ENV["VIEW_COMPONENT_PATH"]

gem "kramdown", "~> 2.4"
gem "sourcemap", "~> 0.1"

group :test do
  gem "webmock"

  # Disallow v5.19 for now since it breaks mocha.
  # See: https://github.com/freerange/mocha/issues/614
  # Remove this line when mocha has fixed the issue
  gem "minitest", "< 5.22"
end

# development dependencies
group :development do
  gem "allocation_stats", "~> 0.1"
  gem "allocation_tracer", "~> 0.6.3"
  gem "benchmark-ips", "~> 2.13.0"
  gem "capybara", "~> 3.39.2"
  gem "cuprite", "~> 0.14.3"
  gem "erb_lint", "~> 0.4.0"
  gem "erblint-github", "~> 0.5.1"
  gem "listen", "~> 3.0"
  gem "matrix", "~> 0.4.2"
  gem "mocha"
  gem "pry"
  gem "rubocop"
  gem "rubocop-github", "~> 0.20.0"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rails-accessibility", "~> 0.2.0"
  gem "simplecov", "~> 0.22.0"
  gem "simplecov-console", "~> 0.9.1"
  gem "sprockets"
  gem "sprockets-rails"
  gem "thor"
  gem "timecop"
  gem "yard", "~> 0.9.25"
end
