# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "erb_lint/all"
require "minitest/autorun"
require "mocha/minitest"
require "rails"
require "rails/test_help"
require "view_component/test_helpers"
require "test_helpers/component_test_helpers"
require "test_helpers/env_helper"
require "yard/docs_helper"
require "pry"
require "yaml"

if ENV["COVERAGE"] == "1"
  require "simplecov"
  require "simplecov-console"

  SimpleCov.start do
    command_name "rails#{ENV['RAILS_VERSION']}-ruby#{ENV['RUBY_VERSION']}" if ENV["RUBY_VERSION"]
    formatter SimpleCov::Formatter::Console

    add_filter "/test/"
    add_filter "/demo/"

    add_group "Components", "app/components"
    add_group "Helpers", "app/lib"
    add_group "Classify", "lib/primer/classify"
    add_group "ERB Linters", "lib/primer/view_components/linters"
    add_group "Rubocop", "lib/rubocop"
    add_group "Gem" do |src|
      src.filename.starts_with?("#{SimpleCov.root}/lib/primer/view_components") && !src.filename.include?("linters")
    end
    add_group "Ignored Code" do |src|
      File.readlines(src.filename).grep(/:nocov:/).any?
    end
  end
end

require File.expand_path("../demo/config/environment.rb", __dir__)

require "primer/view_components"
require "primer/view_components/linters"
