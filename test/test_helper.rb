require "pry"
require "bundler/setup"

ENV["RAILS_ENV"] = "test"

require File.expand_path("../config/environment.rb", __FILE__)
require "rails/test_help"
require "view_component/test_helpers"

require "minitest/autorun"
require "primer/view_components"
