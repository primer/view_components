# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

if ENV["COVERAGE"] == "1"
  require "simplecov"

  if ENV["CI"] == "true"
    SimpleCov.formatter SimpleCov::Formatter::SimpleFormatter
  else
    require "simplecov-console"
    SimpleCov::Formatter::Console.output_style = "table"
  end
end

require "action_controller/railtie"
require "active_model/railtie"
require "minitest/autorun"
require "mocha/minitest"
require "primer/view_components"
require "rails"
require "rails/test_help"
require "rails/test_unit/railtie"
require "test_helpers/component_test_helpers"
require "view_component/test_helpers"

require File.expand_path("../demo/config/environment.rb", __dir__)
