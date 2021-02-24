# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents

      initializer "primer_view_components.assets" do |app|
        if app.config.respond_to?(:assets)
          app.config.assets.precompile += %w(primer_view_components)
        end
      end
    end
  end
end

require "#{Primer::ViewComponents::Engine.root}/app/components/primer/view_components.rb"
