# frozen_string_literal: true

module Primer
  class TooltipComponent < Primer::Component
    ALIGN_DEFAULT = nil
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :left, :right].freeze

    DIRECTION_DEFAULT = :n
    DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :ne, :e, :se, :s, :sw, :w, :nw].freeze

    def initialize(label:, direction: DIRECTION_DEFAULT, align: ALIGN_DEFAULT, multiline: false, no_delay: false, **kwargs)
      align = fetch_or_fallback(ALIGN_OPTIONS, align&.to_sym, ALIGN_DEFAULT)
      direction = fetch_or_fallback(DIRECTION_OPTIONS, direction.to_sym, DIRECTION_DEFAULT)

      @kwargs = kwargs
      @kwargs["aria-label"] = label
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "tooltiped",
        "tooltipped-#{direction}",
        "tooltipped-align-right-1" => align == :right,
        "tooltipped-align-left-1" => align == :left,
        "tooltipped-multiline" => multiline,
        "tooltipped-no-delay" => no_delay
      )
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
