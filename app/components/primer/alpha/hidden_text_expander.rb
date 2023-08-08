# frozen_string_literal: true

module Primer
  module Alpha
    # Use `HiddenTextExpander` to indicate and toggle hidden text.
    #
    # @accessibility
    #   `HiddenTextExpander` requires an `aria-label`, which will provide assistive technologies with an accessible label.
    #   The `aria-label` should describe the action to be invoked by the `HiddenTextExpander`. For instance,
    #   if your `HiddenTextExpander` expands a list of 5 comments, the `aria-label` should be
    #   `"Expand 5 more comments"` instead of `"More"`.
    class HiddenTextExpander < Primer::Component
      status :alpha

      # @param inline [Boolean] Whether or not the expander is inline.
      # @param button_arguments [Hash] <%= link_to_system_arguments_docs %> for the button element.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(inline: false, button_arguments: {}, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @button_arguments = button_arguments

        @system_arguments[:tag] = :span
        @system_arguments[:classes] = class_names(
          "hidden-text-expander",
          @system_arguments[:classes],
          "inline" => inline
        )

        aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label) || @aria_label
        if aria_label.present?
          @button_arguments[:"aria-label"] = aria_label
          @system_arguments[:aria]&.delete(:label)
        end

        @button_arguments[:classes] = class_names(
          "ellipsis-expander",
          button_arguments[:classes]
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) do
          render(Primer::Alpha::HellipButton.new(**@button_arguments))
        end
      end
    end
  end
end
