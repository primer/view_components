# frozen_string_literal: true

require "test_helper"

if ENV["COVERAGE"] == "1"
  require "simplecov"
  require "simplecov-console"

  SimpleCov.start do
    add_filter [
      "app/components/",
      "previews/"
    ]
  end
end

require "erb_lint/all"
require "primer/view_components/linters"
