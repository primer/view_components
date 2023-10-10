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
        def initialize(
          label:,
          selected: false,
          icon: nil,
          hide_labels: false,
          **system_arguments
        )
          @selected = selected

          @system_arguments = system_arguments
          @system_arguments[:"data-action"] = "click:segmented-control#select" if system_arguments[:href].nil?
          @system_arguments[:"aria-current"] = selected
          @system_arguments[:scheme] = :invisible

          if hide_labels
            @button = Primer::Beta::IconButton.new(
              icon: icon,
              "aria-label": label,
              **@system_arguments
            )
          else
            @button = Primer::Beta::Button.new(**@system_arguments)
            @button.with_leading_visual_icon(icon: icon) if icon
            @button.with_content(label)
          end
        end

        # @!parse
        #   # Optional trailing Label
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %>'s `with_trailing_visual_label` slot.
        #   renders_one(:trailing_visual_label)

        # Optional trailing label.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::Button) %>'s `with_trailing_visual_label` slot.
        def with_trailing_visual_label(**system_arguments, &block)
          @button.with_trailing_visual_label(**system_arguments, &block)
        end

        private

        def before_render
          content
        end
      end
    end
  end
end
