# frozen_string_literal: true

module Primer
  module Alpha
    # Use a segmented control to let users select an option from a short list and immediately apply the selection
    # @accessibility
    #   A `SegmentedControl` should not be used in a form as a replacement for something like a radio group or select.
    #   See the [Accessibility section](https://primer.style/design/components/segmented-control#accessibility) of the SegmentedControl interface guidelines for more details.
    class SegmentedControl < Primer::Component
      status :alpha
      audited_at "2023-02-01"

      FULL_WIDTH_DEFAULT = false
      HIDE_LABELS_DEFAULT = false

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "SegmentedControl--small",
        :medium => "SegmentedControl--medium",
        DEFAULT_SIZE => "SegmentedControl--medium"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      # Use to render an item in the segmented control
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, lambda { |label:, selected: false, icon: nil, **system_arguments|
        Primer::Alpha::SegmentedControl::Item.new(
          label: label,
          selected: selected,
          icon: icon,
          hide_labels: @hide_labels,
          size: @size,
          block: @full_width,
          **system_arguments
        )
      }

      # @param hide_labels [Boolean] Whether to hide the labels and only show the icons
      # @param full_width [Boolean] If the component should be full width
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(hide_labels: HIDE_LABELS_DEFAULT, full_width: FULL_WIDTH_DEFAULT, size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @full_width = full_width
        @size = size
        @hide_labels = hide_labels

        @system_arguments = system_arguments
        @system_arguments[:tag] = :ul
        @system_arguments[:role] = "list"
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)],
          "SegmentedControl",
          "SegmentedControl--iconOnly": hide_labels,
          "SegmentedControl--fullWidth": full_width
        )

        validate_aria_label
      end

      def render?
        valid_items_count = items.count <= (@hide_labels ? 6 : 5) && items.count >= 2
        raise ArgumentError, "A segmented control should have 2–5 choices with text labels, or up to 6 icon-only buttons." if !valid_items_count && !Rails.env.production?

        valid_items_count
      end
    end
  end
end
