# frozen_string_literal: true

require_relative "boot"

require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "view_component/engine"
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

    config.public_file_server.enabled = true

    config.view_component.default_preview_layout = "component_preview"
    config.view_component.preview_controller = "PreviewController"
    config.view_component.show_previews = true
    config.view_component.preview_paths << Rails.root.join("..", "test", "previews")


    config.lookbook.project_name = "Primer Lookbook"
    config.lookbook.debug_menu = true

    config.action_dispatch.default_headers.clear

    config.action_dispatch.default_headers = {
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Request-Method" => %w[GET].join(",")
    }
  end
end
