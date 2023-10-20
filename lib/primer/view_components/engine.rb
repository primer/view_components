# frozen_string_literal: true

require "rails/engine"
require "primer/classify/utilities"
require "primer/view_components/asset_injection_middleware"

module Primer
  module ViewComponents
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents

      config.autoload_paths = %W[
        #{root}/lib
      ]

      config.eager_load_paths = %W[
        #{root}/app/components
        #{root}/app/forms
        #{root}/app/helpers
        #{root}/app/lib
      ]

      config.primer_view_components = ActiveSupport::OrderedOptions.new

      config.primer_view_components.raise_on_invalid_options = false
      config.primer_view_components.silence_deprecations = false
      config.primer_view_components.validate_class_names = !Rails.env.production?
      config.primer_view_components.raise_on_invalid_aria = false

      initializer "primer_view_components.assets" do |app|
        if app.config.respond_to?(:assets)
          app.config.assets.precompile += %w[primer_view_components]

          css_root = root.join("app", "assets", "styles")
          css_files = Dir.chdir(css_root) { Dir.glob(File.join("primer_view_components", "*.css")) }
                         .map { |path| path.chomp(".css") }
          app.config.assets.precompile += css_files

          ActiveSupport.on_load :action_controller_base do
            require "primer/asset_helper"
            helper Primer::AssetHelper
          end

          app.config.middleware.use(Primer::ViewComponents::AssetInjectionMiddleware)
        end
      end

      initializer "primer.eager_load_actions" do
        ActiveSupport.on_load(:after_initialize) do
          if Rails.application.config.eager_load
            Primer::Forms::Base.compile!
            Primer::Forms::Base.descendants.each(&:compile!)
            Primer::Forms::BaseComponent.descendants.each(&:compile!)
            Primer::Octicon::Cache.preload!
          end
        end
      end

      initializer "primer.forms.helpers" do
        ActiveSupport.on_load :action_controller_base do
          require "primer/form_helper"
          helper Primer::FormHelper

          # make primer_form_with available to view components also
          ViewComponent::Base.prepend(Primer::FormHelper)
        end
      end

      initializer "primer_view_components.zeitwerk_ignore" do
        Rails.autoloaders.each do |autoloader|
          autoloader.ignore(Engine.root.join("lib", "primer", "view_components", "linters.rb"))
          autoloader.ignore(Engine.root.join("lib", "primer", "view_components", "linters", "**", "*.rb"))
          autoloader.ignore(Engine.root.join("lib", "primer", "view_components", "statuses.rb"))
          autoloader.ignore(Engine.root.join("lib", "primer", "view_components", "audited.rb"))
        end
      end

      config.after_initialize do |app|
        ::Primer::Classify::Utilities.validate_class_names = app.config.primer_view_components.delete(:validate_class_names)

        ViewComponent::Base.prepend(Module.new do
          def render_in(view_context)
            if self.class.name.start_with?("Primer::")
              view_context.request.env["rendered_view_component_classes"] << self.class
            end

            super
          end
        end)

        # Primer::Forms::ActsAsComponent::InstanceMethods.prepend(Module.new do
        #   def render_in(view_context)
        #     view_context.request.env["rendered_view_component_classes"] << self.class
        #     super
        #   end
        # end)
      end
    end
  end
end
