# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SegmentedControl < Primer::Component
      status :alpha

      FULL_WIDTH_DEFAULT = false

      ICON_ONLY_DEFAULT = :never
      ICON_ONLY_MAPPINGS = {
        ICON_ONLY_DEFAULT => "",
        :always => "SegmentedControl--iconOnly",
        :when_narrow => "SegmentedControl--iconOnly-whenNarrow"
      }.freeze
      ICON_ONLY_OPTIONS = ICON_ONLY_MAPPINGS.keys

      # Use to render an item in the segmented control
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :items, lambda { |label:, selected: false, icon: nil, **system_arguments|
        Primer::Alpha::SegmentedControl::Item.new(
          label: label,
          selected: selected,
          icon: icon,
          icon_only: @icon_only,
          size: @size,
          block: @full_width,
          **system_arguments
        )
      }

      # @example Basic usage
      #
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_item(label: "Preview", selected: true) %>
      #     <%= c.with_item(label: "Raw") %>
      #     <%= c.with_item(label: "Blame") %>
      #   <% end %>
      #
      # @example With icons
      #   <%= render(Primer::Alpha::SegmentedControl.new) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @example With icons only
      #   <%= render(Primer::Alpha::SegmentedControl.new(icon_only: :always)) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @example With icons only when narrow
      #   <%= render(Primer::Alpha::SegmentedControl.new(icon_only: :when_narrow)) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @example Fill width of parent
      #   <%= render(Primer::Alpha::SegmentedControl.new(full_width: true)) do |c| %>
      #     <%= c.with_item(label: "Preview", icon: :eye, selected: true) %>
      #     <%= c.with_item(label: "Raw", icon: :"file-code") %>
      #     <%= c.with_item(label: "Blame", icon: :people) %>
      #   <% end %>
      #
      # @param icon_only [Symbol] <%= one_of(Primer::Alpha::SegmentedControl::ICON_ONLY_OPTIONS) %>
      # @param full_width [Boolean] If the component should be full width
      # @param size [Symbol] <%= one_of(Primer::Beta::Button::SIZE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(icon_only: ICON_ONLY_DEFAULT, full_width: FULL_WIDTH_DEFAULT, size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @icon_only = fetch_or_fallback(ICON_ONLY_OPTIONS, icon_only, ICON_ONLY_DEFAULT)
        @full_width = full_width
        @size = size

        @system_arguments = system_arguments
        @system_arguments[:tag] = :ul
        @system_arguments[:role] = "list"
        @system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "SegmentedControl",
          ICON_ONLY_MAPPINGS[icon_only],
          "SegmentedControl--fullWidth": full_width
        )
      end
    end
  end
end
