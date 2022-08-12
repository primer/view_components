# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # `SegmentedControl::Button` is used inside `SegmentedControl` to render a button.
      class Button < Primer::Component
        status :alpha

        ICON_ONLY_DEFAULT = :never
        ICON_ONLY_MAPPINGS = {
          ICON_ONLY_DEFAULT => "",
          :always => "SegmentedControl-button--iconOnly",
          :when_narrow => "SegmentedControl-button--iconOnly-whenNarrow"
        }.freeze
        ICON_ONLY_OPTIONS = ICON_ONLY_MAPPINGS.keys

        def initialize(icon: nil, icon_only: ICON_ONLY_DEFAULT, selected: false, **system_arguments)
          @system_arguments = system_arguments

          # Icons
          @icon = icon
          @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)

          @system_arguments[:id] ||= "segmented-control-button-#{SecureRandom.hex(4)}" if tooltip?
          @system_arguments[:classes] = class_names(
            "SegmentedControl-button",
            ICON_ONLY_MAPPINGS[@icon_only]
          )
          @system_arguments[:'aria-current'] = selected
        end

        private

        def tooltip?
          @icon_only == :when_narrow || @icon_only == :always
        end

        def trimmed_content
          return if content.blank?

          trimmed_content = content.strip

          return trimmed_content unless content.html_safe?

          # strip unsets `html_safe`, so we have to set it back again to guarantee that HTML blocks won't break
          trimmed_content.html_safe # rubocop:disable Rails/OutputSafety
        end
      end
    end
  end
end
