# frozen_string_literal: true

module Primer
  class DropdownMenuComponent < Primer::Component
    SCHEME_DEFAULT = :default
    SCHEME_MAPPINGS = {
      SCHEME_DEFAULT => "",
      :dark => "dropdown-menu-dark",
    }.freeze

    DIRECTION_DEFAULT = :se
    DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :sw, :w, :e, :ne, :s]

    def initialize(direction: DIRECTION_DEFAULT, scheme: SCHEME_DEFAULT, header: nil, **kwargs)
      @header, @direction, @kwargs = header, direction, kwargs

      @kwargs[:tag] = "details-menu"
      @kwargs[:role] = "menu"

      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "dropdown-menu",
        "dropdown-menu-#{fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT)}",
        SCHEME_MAPPINGS[fetch_or_fallback(SCHEME_MAPPINGS.keys, scheme, SCHEME_DEFAULT)]
      )
    end
  end
end
