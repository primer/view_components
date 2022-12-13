# frozen_string_literal: true

module Primer
  # DropdownMenus are lightweight context menus for housing navigation and actions.
  # They're great for instances where you don't need the full power (and code)
  # of the select menu.
  class DropdownMenuComponent < Primer::Component
    status :deprecated

    SCHEME_DEFAULT = :default
    SCHEME_MAPPINGS = {
      SCHEME_DEFAULT => "",
      :dark => "dropdown-menu-dark"
    }.freeze

    DIRECTION_DEFAULT = :se
    DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :sw, :w, :e, :ne, :s].freeze

    # @example With a header
    #   <div>
    #     <%= render(Primer::Beta::Details.new(overlay: :default, reset: true, position: :relative)) do |component| %>
    #       <% component.with_summary do %>
    #         Dropdown
    #       <% end %>
    #
    #       <% component.with_body do %>
    #         <%= render(Primer::DropdownMenuComponent.new(header: "Options")) do %>
    #           <ul>
    #             <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
    #             <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
    #             <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
    #           </ul>
    #         <% end %>
    #       <% end %>
    #     <% end %>
    #   </div>
    #
    # @param direction [Symbol] <%= one_of(Primer::DropdownMenuComponent::DIRECTION_OPTIONS) %>
    # @param scheme [Symbol] Pass `:dark` for dark mode theming
    # @param header [String] Optional string to display as the header
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(direction: DIRECTION_DEFAULT, scheme: SCHEME_DEFAULT, header: nil, **system_arguments)
      @header = header
      @direction = direction
      @system_arguments = deny_tag_argument(**system_arguments)

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
