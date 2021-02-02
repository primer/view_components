# frozen_string_literal: true

module Primer
  # :nodoc
  class UnderlineNavComponent < Primer::Component
    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right].freeze

    with_content_areas :body, :actions

    def initialize(align: ALIGN_DEFAULT, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] = :nav
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "UnderlineNav",
        "UnderlineNav--right" => @align == :right
      )
    end
  end
end
