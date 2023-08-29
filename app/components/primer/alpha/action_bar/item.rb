# frozen_string_literal: true

# :nocov:

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class Item < Primer::Component
        def initialize(item_type)
          @system_arguments = {
            tag: :div,
            data: {
              targets: "action-bar.items"
            },
            classes: "ActionBar-item"
          }
          @item_type = item_type
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { render(@item_type) }
        end
      end
    end
  end
end
