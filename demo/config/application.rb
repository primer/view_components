# frozen_string_literal: true

require_relative "boot"

require "action_controller/railtie"
require "action_view/railtie"
require "active_model/railtie"
require "sprockets/railtie"
require "view_component"
require "primer/view_components"
require "primer/view_components/engine"
require "octicons"
require_relative "../../lib/primer/yard"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  # :nocov:
  class Application < Rails::Application
    if Rails.version.to_i >= 7.1
      config.load_defaults 7.1
    elsif Rails.version.to_i >= 7
      config.load_defaults 7.0
    elsif Rails.version.to_i >= 6
      config.load_defaults 6.0
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.view_component.default_preview_layout = "component_preview"
    config.view_component.show_previews = true
    config.view_component.preview_controller = "PreviewController"
    config.view_component.preview_paths << Rails.root.join("..", "previews")

    config.autoload_paths << Rails.root.join("..", "test", "forms")
    config.autoload_paths << Rails.root.join("..", "test", "test_helpers", "components")

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
          assets = data.preview.components.flat_map do |component|
            asset_files = Dir[Primer::ViewComponents.root.join("app", "components", "#{component.relative_file_path.to_s.chomp('.rb')}.{css,ts}")]
            asset_files.map do |path_str|
              path = Pathname(path_str)
              { path: path, language: path.extname == ".ts" ? :js : :css }
            end
          end

          assets += data.scenarios.each_with_object([]) do |rendered_scenario, memo|
            form_constants = rendered_scenario.source.match(/([\w:]+Form)\.new/)&.captures || []
            form_constants.each do |form_constant|
              path, = Kernel.const_source_location(form_constant)
              memo << { path: Pathname(path), language: :ruby }

              const = Kernel.const_get(form_constant)
              next unless const.template_root_path

              Dir[File.join(const.template_root_path, "*_caption.html.erb")].each do |template_caption_path|
                memo << { path: Pathname(template_caption_path), language: :erb }
              end

              after_content_path = Pathname(File.join(const.template_root_path, "after_content.html.erb"))
              memo << { path: after_content_path, language: :erb } if after_content_path.exist?
            end
          end

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
        ],
        # rubocop:disable Style/WordArray
        primitives: [
          ["Default", "default"],
          ["Next Major v8", "next_major_v8"]
        ]
        # rubocop:enable Style/WordArray
      }

      config.lookbook.preview_embeds.policy = "ALLOWALL"
      config.lookbook.page_paths = [Rails.root.join("..", "previews", "pages")]
      config.lookbook.component_paths = [Primer::ViewComponents::Engine.root.join("app", "components")]

      ActiveSupport.on_load(:action_controller) do
        require "primer/yard/lookbook_docs_helper"
        Lookbook::PageHelper.include(Primer::Yard::LookbookDocsHelper)
      end
    end
  end
end
