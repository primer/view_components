# frozen_string_literal: true

require "primer/view_components"

module Primer
  module ViewComponents
    class Engine < ::Rails::Engine
      isolate_namespace Primer::ViewComponents

      if Rails.env.development?
        config.to_prepare do
          require_dependency Primer::ViewComponents::Engine.root.join("app", "components", "primer", "view_components.rb")
          Primer::ViewComponents::PATHS.each do |path|
            require_dependency Primer::ViewComponents::Engine.root.join(path)
          end
        end

        config.after_initialize do
          Rails.application.config.reload_classes_only_on_change = false
        end
      end
    end
  end
end

require "#{Primer::ViewComponents::Engine.root}/app/components/primer/view_components.rb" unless Rails.env.development?
