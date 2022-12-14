# frozen_string_literal: true

module Primer
  module Alpha
    # Use a segmented control to let users select an option from a short list and immediately apply the selection
    class SegmentedControl < Primer::Component
      status :alpha

      FULL_WIDTH_DEFAULT = false
      HIDE_LABELS_DEFAULT = false

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

      # @example Basic usage
      #
      #   <%= render(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |c| %>
      #     <%= c.with_item(label: "Preview", selected: true) %>
      #     <%= c.with_item(label: "Raw") %>
      #     <%= c.with_item(label: "Blame") %>
      #   <% end %>
      #
      # @example Small
      #
      #   <%= render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", size: :small)) do |c| %>
      #     <%= c.with_item(label: "Preview", selected: true) %>
      #     <%= c.with_item(label: "Raw") %>
      #     <%= c.with_item(label: "Blame") %>
      #   <% end %>
      #
      # @example With icons
      #   <%= render(Primer::Alpha::SegmentedControl.new("aria-label": "File view")) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @example With icons only
      #   <%= render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", hide_labels: true)) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @example Fill width of parent
      #   <%= render(Primer::Alpha::SegmentedControl.new("aria-label": "File view", full_width: true)) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
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
          "SegmentedControl",
          "SegmentedControl--iconOnly": hide_labels,
          "SegmentedControl--fullWidth": full_width
        )
      end

      def render?
        valid_items_count = items.count <= (@hide_labels ? 6 : 5) && items.count >= 2
        raise ArgumentError, "A segmented control should have 2–5 choices with text labels, or up to 6 icon-only buttons." if !valid_items_count && !Rails.env.production?

        valid_items_count
      end
    end
  end
end
