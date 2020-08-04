# frozen_string_literal: true

require File.expand_path("../boot", __FILE__)

require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

module Demo
  class Application < Rails::Application
    config.action_controller.asset_host = "http://assets.example.com"
  end
end

Demo::Application.config.secret_key_base = "foo"

require "primer/view_components/engine"
