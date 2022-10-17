# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

if ENV["COVERAGE"] == "1"
  require "simplecov"

  SimpleCov.formatter SimpleCov::Formatter::SimpleFormatter
end

require "minitest/autorun"
require "mocha/minitest"
require "rails"
require "rails/test_help"
require "view_component/test_helpers"
require "test_helpers/assert_allocations_helper"
require "test_helpers/component_test_helpers"
require "yard/docs_helper"
require "pry"
require "yaml"
require "action_controller/railtie"
require "rails/test_unit/railtie"
require "active_model/railtie"
require "webmock/minitest"

require "primer/view_components"

require File.expand_path("../demo/config/environment.rb", __dir__)

WebMock.disable_net_connect!(allow_localhost: true)
