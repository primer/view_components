# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # SegmentedControl::Item is a private component that is only used by SegmentedControl
      # It wraps the Button and IconButton components to provide the correct styles
      class Item < Primer::BaseComponent
        status :alpha

        # @param label [String] The label to use
        # @param selected [Boolean] Whether the item is selected
        # @param icon [Symbol] The icon to use
        # @param icon_only [Symbol] Whether to only show the icon
        def initialize(label:, selected: false, icon: nil, icon_only: ICON_ONLY_DEFAULT, **system_arguments)
          @icon = icon
          @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)
          @label = label
          @selected = selected

          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select"
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible
          @system_arguments[:id] ||= "segmented-item-#{SecureRandom.hex(4)}" if @icon_only == :when_narrow || @system_arguments[:id]
        end
      end
    end
  end
end
