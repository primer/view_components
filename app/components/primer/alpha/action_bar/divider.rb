# frozen_string_literal: true
# :nocov:

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class Divider < Primer::Component
        def initialize
          @system_arguments = {
            tag: :hr,
            role: :presentation,
            aria: {
              hidden: true
            },
            data: {
              targets: "action-bar.items"
            },
            classes: "ActionBar-item ActionBar-divider"
          }
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
