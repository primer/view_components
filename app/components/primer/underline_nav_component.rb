# frozen_string_literal: true

module Primer
  class UnderlineNavComponent < Primer::Component
    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right]

    with_content_areas :body, :actions

    def initialize(align: ALIGN_DEFAULT, **kwargs)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @kwargs = kwargs
      @kwargs[:tag] = :nav
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "UnderlineNav",
        "UnderlineNav--right" => @align == :right
      )
    end
  end
end
