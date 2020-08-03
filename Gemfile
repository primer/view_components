source "https://rubygems.org"

# Specify your gem's dependencies in primer_view_components.gemspec
gemspec
rails_version = "#{ENV['RAILS_VERSION'] || '6.0.3.2'}"

gem "capybara", "~> 3"
gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
gem "rake", "~> 12.0"
gem "minitest", "~> 5.0"
