# frozen_string_literal: true

require "rails/engine"
require "primer/classify/utilities"

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
        app.config.assets.precompile += %w[primer_view_components] if app.config.respond_to?(:assets)
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
      end
    end
  end
end
