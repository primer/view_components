# frozen_string_literal: true

require "rails/engine"

module Primer
  module ViewComponents
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents
      config.autoload_once_paths = %W[
        #{root}/app/components
        #{root}/app/lib
      ]

      config.primer_view_component = ActiveSupport::OrderedOptions.new
      config.primer_view_component.force_functional_colors = false

      initializer "primer_view_components.assets" do |app|
        app.config.assets.precompile += %w[primer_view_components] if app.config.respond_to?(:assets)
      end
    end
  end
end
