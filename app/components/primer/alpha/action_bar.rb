# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ActionBar < Primer::Component
      status :alpha

      DENSITY_DEFAULT = :normal
      DENSITY_MAPPINGS = {
        DENSITY_DEFAULT => nil,
        :condensed => "ActionBar--condensed",
        :spacious => "ActionBar--spacious"
      }.freeze
      DENSITY_OPTIONS = DENSITY_MAPPINGS.keys.freeze

      DIRECTION_DEFAULT = :horizontal
      DIRECTION_MAPPINGS = {
        DIRECTION_DEFAULT => nil,
        :vertical => "ActionBar--vertical"
      }.freeze
      DIRECTION_OPTIONS = DIRECTION_MAPPINGS.keys.freeze

      renders_many :items, types: {
        icon_button: lambda { |**system_arguments|
          Primer::Alpha::ActionBar::Item.new(item_type: :icon_button, **system_arguments)
        },
        divider: lambda { |**system_arguments|
          Primer::Alpha::ActionBar::Item.new(item_type: :divider, **system_arguments)
        }
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::ActionBar.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(density: DENSITY_DEFAULT, direction: DIRECTION_DEFAULT, **system_arguments)
        @menu_id = "action-bar-overflow-menu-#{SecureRandom.hex(4)}"
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"action-bar"

        @density = fetch_or_fallback(DENSITY_OPTIONS, density, DENSITY_DEFAULT)
        @direction = fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)

        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "ActionBar",
          DENSITY_MAPPINGS[@density],
          DIRECTION_MAPPINGS[@direction]
        )
        @system_arguments[:role] = "toolbar"
      end
    end
  end
end
