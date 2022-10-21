# frozen_string_literal: true

require "test_helper"

if ENV["COVERAGE"] == "1"
  require "simplecov"

  SimpleCov.add_filter [
    "lib/",
    "app/forms/"
  ]
end
