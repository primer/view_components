# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # SegmentedControl::Item is a private component that is only used by SegmentedControl
      # It wraps the Button and IconButton components to provide the correct styles
      class Item < Primer::BaseComponent
        status :alpha

        def initialize(label:, icon: nil, selected: false, icon_only: ICON_ONLY_DEFAULT, **system_arguments)
          @selected = selected
          @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)
          @label = label
          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select"
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible
          @system_arguments[:id] ||= "segmented-item-#{SecureRandom.hex(4)}" if @icon_only == :when_narrow || @system_arguments[:id]
          @icon = icon
        end
      end
    end
  end
end
