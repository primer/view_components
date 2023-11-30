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

require "minitest/autorun"
require "mocha/minitest"
require "rails"
require "rails/test_help"
require "view_component/test_helpers"
require "test_helpers/component_test_helpers"
require "test_helpers/clipboard_test_helpers"
require "test_helpers/js_test_helpers"
require "action_controller/railtie"
require "rails/test_unit/railtie"
require "active_model/railtie"
require "primer/view_components"

require File.expand_path("../demo/config/environment.rb", __dir__)
