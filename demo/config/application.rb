# frozen_string_literal: true

require_relative "boot"

require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "view_component/engine"
require "view_component/storybook/engine"
require "primer/view_components/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    if Rails.version.to_i >= 7
      config.load_defaults 7.0
    elsif Rails.version.to_i >= 6
      config.load_defaults 6.0
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.view_component_storybook.show_stories = true
    config.view_component.show_previews = true
    config.view_component.preview_controller = "PreviewController"

    config.action_dispatch.default_headers.clear

    config.action_dispatch.default_headers = {
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Request-Method" => %w[GET].join(",")
    }
  end
end
