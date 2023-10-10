# frozen_string_literal: true

module Primer
  module Alpha
    class SegmentedControl
      # SegmentedControl::Item is a private component that is only used by SegmentedControl
      # It wraps the Button and IconButton components to provide the correct styles
      class Item < Primer::BaseComponent
        status :alpha
        audited_at "2023-02-01"

        # @param label [String] The label to use
        # @param selected [Boolean] Whether the item is selected
        # @param icon [Symbol] The icon to use
        # @param hide_labels [Symbol] Whether to only show the icon
        # @param trailing_visual_label [String] A trailing visual label that appears to the right of the item
        # @param trailing_visual_label_options [Hash] <% Same arguments as <%= link_to_component(Primer::Beta::Label) %>
        def initialize(
          label:,
          selected: false,
          icon: nil,
          hide_labels: false,
          trailing_visual_label: nil,
          trailing_visual_label_options: {},
          **system_arguments
        )
          @icon = icon
          @hide_labels = hide_labels
          @label = label
          @selected = selected
          @trailing_visual_label = trailing_visual_label
          @trailing_visual_label_options = trailing_visual_label_options

          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select" if system_arguments[:href].nil?
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible
        end
      end
    end
  end
end
