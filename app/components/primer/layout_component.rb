# frozen_string_literal: true

module Primer
  class LayoutComponent < Primer::Component
    with_content_areas :main, :sidebar

    DEFAULT_SIDE = :right
    ALLOWED_SIDES = [DEFAULT_SIDE, :left]

    def initialize(responsive: false, side: DEFAULT_SIDE, **kwargs)
      @kwargs = kwargs
      @side = fetch_or_fallback(ALLOWED_SIDES, side, DEFAULT_SIDE)
      @responsive = responsive
      @kwargs[:classes] = class_names(
        "gutter-condensed gutter-lg",
        @kwargs[:classes]
      )
      @kwargs[:direction] = responsive ? [:column, nil, :row] : nil
    end
  end
end
