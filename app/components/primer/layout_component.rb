# frozen_string_literal: true

module Primer
  class LayoutComponent < Primer::Component
    with_content_areas :main, :sidebar

    DEFAULT_SIDE = :right
    ALLOWED_SIDES = [DEFAULT_SIDE, :left].freeze

    MAX_COL = 12
    DEFAULT_SIDEBAR_COL = 3
    ALLOWED_SIDEBAR_COLS = (1..(MAX_COL - 1)).to_a.freeze

    def initialize(responsive: false, side: DEFAULT_SIDE, sidebar_col: DEFAULT_SIDEBAR_COL, **kwargs)
      @kwargs = kwargs
      @side = fetch_or_fallback(ALLOWED_SIDES, side, DEFAULT_SIDE)
      @responsive = responsive
      @kwargs[:classes] = class_names(
        "gutter-condensed gutter-lg",
        @kwargs[:classes]
      )
      @kwargs[:direction] = responsive ? [:column, nil, :row] : nil

      @sidebar_col = fetch_or_fallback(ALLOWED_SIDEBAR_COLS, sidebar_col, DEFAULT_SIDEBAR_COL)
      @main_col = MAX_COL - @sidebar_col
    end
  end
end
