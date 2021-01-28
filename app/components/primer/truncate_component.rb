# frozen_string_literal: true

module Primer
  class TruncateComponent < Primer::Component
    ALIGN_DEFAULT = :left
    ALIGN_OPTIONS = [ALIGN_DEFAULT, :right]

    def initialize(align: ALIGN_DEFAULT, inline: false, expandable: false, **system_arguments)
      @align = fetch_or_fallback(ALIGN_OPTIONS, align, ALIGN_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "css-truncate",
        "css-truncate-overflow" => !inline,
        "css-truncate-target" => inline,
        "expandable" => expandable
      )
    end
  end
end
