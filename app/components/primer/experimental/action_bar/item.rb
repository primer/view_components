# frozen_string_literal: true

module Primer
  module Experimental
    class ActionBar
      # :nodoc:
      class Item < Primer::Component
        ITEM_TYPES = [:icon_button, :divider].freeze
        ITEM_TYPE_DEFAULT = :icon_button

        attr_reader :icon, :label

        def initialize(item_type:, **system_arguments)
          @item_type = fetch_or_fallback(ITEM_TYPES, item_type, ITEM_TYPE_DEFAULT)
          @system_arguments = system_arguments

          if icon_button?
            @icon = system_arguments[:icon]
            @label = system_arguments[:"aria-label"]
            @system_arguments[:scheme] = :invisible
          elsif divider?
            @system_arguments[:tag] = :hr
            @system_arguments[:"data-targets"] = "action-bar.items"
            @system_arguments[:classes] = class_names(
              system_arguments[:classes],
              "ActionBar-divider"
            )
          end
        end

        def icon_button?
          @item_type == :icon_button
        end

        def divider?
          @item_type == :divider
        end
      end
    end
  end
end
