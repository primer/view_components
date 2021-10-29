# frozen_string_literal: true

require "rails/engine"
require "primer/classify/utilities"

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
      config.primer_view_components.max_classify_cache_size = 500
      config.primer_view_components.validate_class_names = !Rails.env.production?

      initializer "primer_view_components.assets" do |app|
        app.config.assets.precompile += %w[primer_view_components] if app.config.respond_to?(:assets)
      end

      config.after_initialize do |app|
        ::Primer::Classify::Utilities.validate_class_names = app.config.primer_view_components.delete(:validate_class_names)
      end
    end
  end
end
