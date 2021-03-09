# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require 'mocha/minitest'
require "rails"
require "rails/test_help"
require "view_component/test_helpers"
require "test_helpers/component_test_helpers"
require "pry"

require File.expand_path("../demo/config/environment.rb", __dir__)

require "primer/view_components"

if ENV["COVERAGE"] == "1"
  require "simplecov"
  require "simplecov-console"

  SimpleCov.start do
    command_name "rails#{ENV['RAILS_VERSION']}-ruby#{ENV['RUBY_VERSION']}" if ENV["RUBY_VERSION"]
    formatter SimpleCov::Formatter::Console
  end
end
