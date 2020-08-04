# frozen_string_literal: true

module Primer
  class LayoutComponent < Primer::Component
    with_content_areas :main, :sidebar

    DEFAULT_SIDE = :right
    ALLOWED_SIDES = [DEFAULT_SIDE, :left]

    def initialize(responsive: false, side: DEFAULT_SIDE, **args)
      @responsive, @args = responsive, args

      @side = fetch_or_fallback(ALLOWED_SIDES, side, DEFAULT_SIDE)
    end
  end
end
