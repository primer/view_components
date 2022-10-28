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
        # @param hide_labels [Symbol] Whether to only show the icon
        def initialize(label:, selected: false, icon: nil, hide_labels: false, **system_arguments)
          @icon = icon
          @hide_labels = hide_labels
          @label = label
          @selected = selected

          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select"
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible
        end
      end
    end
  end
end
