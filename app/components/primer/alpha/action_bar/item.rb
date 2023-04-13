# frozen_string_literal: true

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class Item < Primer::Component
        def initialize(**system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] ||= :div
          @system_arguments[:data] = { targets: "action-bar.items" }
          @system_arguments[:classes] = class_names(
            @system_arguments.delete(:classes),
            "ActionBar-item"
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
