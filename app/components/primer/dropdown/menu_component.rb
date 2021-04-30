# frozen_string_literal: true

module Primer
  module Dropdown
    # This component is part of `Dropdown` and should not be
    # used as a standalone component.
    class MenuComponent < Primer::Component
      SCHEME_DEFAULT = :default
      SCHEME_MAPPINGS = {
        SCHEME_DEFAULT => "",
        :dark => "dropdown-menu-dark"
      }.freeze

      DIRECTION_DEFAULT = :se
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :sw, :w, :e, :ne, :s].freeze

      renders_many :items, lambda { |divider: false, **system_arguments|
        system_arguments[:tag] = :li
        system_arguments[:role] = :none if divider
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "dropdown-item" => !divider,
          "dropdown-divider" => divider
        )

        Primer::BaseComponent.new(**system_arguments)
      }

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
