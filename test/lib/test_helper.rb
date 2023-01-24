# frozen_string_literal: true

require "test_helper"

if ENV["COVERAGE"] == "1"
  require "simplecov"

  SimpleCov.add_filter [
    "app/components/",
    "app/lib/"
  ]
end

require "erb_lint/all"
require "primer/view_components/linters"
require "primer/yard/docs_helper"
