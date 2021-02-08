# frozen_string_literal: true

module Primer
  module Dropdown
    # DropdownMenus are lightweight context menus for housing navigation and actions.
    # They're great for instances where you don't need the full power (and code)
    # of the select menu.
    class MenuComponent < Primer::Component
      include ViewComponent::SlotableV2

      SCHEME_DEFAULT = :default
      SCHEME_MAPPINGS = {
        SCHEME_DEFAULT => "",
        :dark => "dropdown-menu-dark"
      }.freeze

      DIRECTION_DEFAULT = :se
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :sw, :w, :e, :ne, :s].freeze

      renders_many :items, lambda { |divider: false, **item_arguments|
        item_arguments[:tag] = :li
        item_arguments[:role] = :none if divider
        item_arguments[:classes] = class_names(
          item_arguments[:classes],
          "dropdown-item" => !divider,
          "dropdown-divider" => divider
        )

        Primer::BaseComponent.new(**item_arguments)
      }

      # @example 200|With a header
      #   <div class="position-relative mt-2">
      #     <%= render(Primer::Dropdown::MenuComponent.new(header: "Options")) do |c|
      #       c.item { "Item 1" }
      #       c.item { "Item 2" }
      #       c.item(divider: true)
      #       c.item { "Item 3" }
      #       c.item { "Item 4" }
      #     end %>
      #   </div>
      #
      # @param direction [Symbol] <%= one_of(Primer::Dropdown::MenuComponent::DIRECTION_OPTIONS) %>
      # @param scheme [Symbol] Pass :dark for dark mode theming
      # @param header [String] Optional string to display as the header
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(direction: DIRECTION_DEFAULT, scheme: SCHEME_DEFAULT, header: nil, **system_arguments)
        @header = header
        @direction = direction
        @system_arguments = system_arguments

        @system_arguments[:tag] = "details-menu"
        @system_arguments[:role] = "menu"

        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "dropdown-menu",
          "dropdown-menu-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}",
          SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, SCHEME_DEFAULT)]
        )
      end
    end
  end
end
