# frozen_string_literal: true

require_relative "boot"

require "action_controller/railtie"
require "action_view/railtie"
require "active_model/railtie"
require "sprockets/railtie"
require "view_component"
require "primer/view_components/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  # :nocov:
  class Application < Rails::Application
    if Rails.version.to_i >= 7
      config.load_defaults 7.0
    elsif Rails.version.to_i >= 6
      config.load_defaults 6.0
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.view_component.default_preview_layout = "component_preview"
    config.view_component.show_previews = true
    config.view_component.preview_controller = "PreviewController"
    config.view_component.preview_paths << Rails.root.join("../previews")

    config.autoload_paths << Rails.root.join("../test/forms")
    config.autoload_paths << Rails.root.join("../test/test_helpers/components")

    config.action_dispatch.default_headers.clear

    config.action_dispatch.default_headers = {
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Request-Method" => %w[GET].join(",")
    }

    if config.respond_to?(:lookbook)
      asset_panel_config = {
        label: "Assets",
        partial: "lookbook/panels/assets",
        locals: lambda do |data|
          assets = data.preview.components.map do |component|
            asset_files = Dir[Rails.root.join("../", "#{component.full_path.to_s.chomp('.rb')}.{css,ts}")]
            asset_files.map { |path| Pathname.new path }
          end.flatten.compact
          { assets: assets }
        end
      }
      Lookbook.define_panel("assets", asset_panel_config)

      config.lookbook.project_name = "Primer ViewComponents v#{Primer::ViewComponents::VERSION::STRING}"
      config.lookbook.preview_display_options = {
        theme: [
          ["Light default", "light"],
          ["Light colorblind", "light_colorblind"],
          ["Light high contrast", "light_high_contrast"],
          ["Dark default", "dark"],
          ["Dark Dimmed", "dark_dimmed"],
          ["Dark high contrast", "dark_high_contrast"],
          ["Dark colorblind", "dark_colorblind"],
          ["All themes", "all"]
        ]
      }
    end
  end
end
