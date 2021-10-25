# frozen_string_literal: true

require "rails/engine"

module Primer
  module ViewComponents
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents
      config.eager_load_paths = %W[
        #{root}/app/components
        #{root}/app/lib
      ]

      config.primer_view_components = ActiveSupport::OrderedOptions.new

      config.primer_view_components.force_system_arguments = false
      config.primer_view_components.silence_deprecations = false
      config.primer_view_components.validate_class_names = !Rails.env.production?

      initializer "primer_view_components.assets" do |app|
        app.config.assets.precompile += %w[primer_view_components] if app.config.respond_to?(:assets)
      end
    end
  end
end
