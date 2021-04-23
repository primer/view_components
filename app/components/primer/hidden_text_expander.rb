# frozen_string_literal: true

module Primer
  # Use HiddenTextExpander to indicate and toggle hidden text.
  class HiddenTextExpander < Primer::Component
    # @example Default
    #   <%= render(Primer::HiddenTextExpander.new) %>
    #
    # @example Inline
    #   <%= render(Primer::HiddenTextExpander.new(inline: true)) %>
    #
    # @example Styling the button
    #   <%= render(Primer::HiddenTextExpander.new(button_arguments: { p: 1, classes: "my-custom-class" })) %>
    #
    # @param inline [Boolean] Whether or not the expander is inline.
    # @param button_arguments [Hash] <%= link_to_system_arguments_docs %> for the button element.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(inline: false, button_arguments: {}, **system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :span
      @system_arguments[:classes] = class_names(
        "hidden-text-expander",
        @system_arguments[:classes],
        "inline" => inline
      )

      @button_arguments = button_arguments
      @button_arguments[:"aria-expanded"] = false
      @button_arguments[:classes] = class_names(
        "ellipsis-expander",
        button_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) do
        render(Primer::BaseButton.new(**@button_arguments)) { "&hellip;" }
      end
    end
  end
end
