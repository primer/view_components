# frozen_string_literal: true

source "https://rubygems.org"

gemspec
rails_version = "#{ENV['RAILS_VERSION'] || '6.0.3.2'}"

gem "capybara", "~> 3"
gem "minitest", "~> 5.0"
gem "puma", "~> 4.3.3"
gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
gem "rake", "~> 12.0"
gem "webpacker", "~> 5.1"

