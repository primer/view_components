# frozen_string_literal: true

source "https://rubygems.org"

gemspec
rails_version = (ENV["RAILS_VERSION"] || "8.0.2").to_s

# Rails main and 8.1.2 onward support Minitest 6.
# Rails 8.0.x lacks support for Minitest 6 in released versions.
# TODO: Remove conditional once a Rails 8.0.x release with Minitest 6 support is cut.
# See: https://github.com/rails/rails/commit/ec62932ee7d31e0ef870e61c2d7de2c3efe3faa6
if rails_version.start_with?("8.0.") || rails_version == "latest"
  # Rails 8.0.x lacks Minitest 6 compatibility in released versions.
  gem "minitest", "< 6"
else
  gem "minitest", "~> 6.0"
  gem "minitest-mock", "~> 5.27"
end
gem "rack-cors"
gem "rake", "~> 13.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
if rails_version == "latest"
  gem "actionview"
  gem "activemodel"
  gem "activesupport"
  gem "railties"
elsif rails_version == "main"
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

# Use Puma as the app server
gem "puma", "~> 7.2.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

gem "lookbook", "~> 2.3.14"
if ENV["VIEW_COMPONENT_PATH"]
  gem "view_component", path: ENV["VIEW_COMPONENT_PATH"]
else
  gem "view_component", "4.5.0"
end

gem "kramdown", "~> 2.5"
gem "sourcemap", "~> 0.1"

gem "cssbundling-rails", "~> 1.4"
gem "vite_rails", "~> 3.0"

group :test do
  gem "webmock"
end

# development dependencies
group :development do
  gem "allocation_stats", "~> 0.1"
  gem "benchmark"
  gem "benchmark-ips", "~> 2"
  gem "capybara", "~> 3.40.0"
  gem "cuprite", "~> 0.15"
  gem "debug"
  gem "erb_lint", "~> 0.9"
  gem "erblint-github", "~> 1.0.1"
  gem "listen", "~> 3.10"
  gem "matrix", "~> 0.4.3"
  gem "mocha"
  gem "rubocop"
  gem "rubocop-github", "~> 0.26.0"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rails-accessibility", "~> 1.0"
  gem "selenium-webdriver", "~> 4.41"
  gem "simplecov", "~> 0.22.0"
  gem "simplecov-console", "~> 0.9.5"
  gem "sprockets"
  gem "sprockets-rails"
  gem "thor"
  gem "timecop"
  gem "yard", "~> 0.9.38"
end
