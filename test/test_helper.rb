# frozen_string_literal: true

require "pry"
require "bundler/setup"

ENV["RAILS_ENV"] = "test"

require File.expand_path("../../demo/config/environment.rb", __FILE__)
require "rails/test_help"
require "view_component/test_helpers"
require "test_helpers/component_test_helpers"

require "minitest/autorun"
require "primer/view_components"
require "primer/view_components/engine"
