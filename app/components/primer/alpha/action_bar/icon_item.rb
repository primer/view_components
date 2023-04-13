# frozen_string_literal: true

module Primer
  module Alpha
    class ActionBar
      # ActionBar::Item is an internal component that wraps the items in a div with the `ActionBar-item` class.
      class IconItem < Primer::Component
        def initialize(id:, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:id] = id
          @system_arguments[:scheme] = :invisible
        end

        def call
          render(Item.new) do
            render(Primer::Beta::IconButton.new(**@system_arguments))
          end
        end
      end
    end
  end
end
