# frozen_string_literal: true

module Primer
  # Use `HellipButton` to render a button with a hellip. Often used for hidden text expanders.
  # @accessibility
  #   Always set an accessible label to help the user interact with the component.
  #
  #   * This button is displaying a hellip as its content (The three dots character). Therefore a label is needed for screen readers.
  #   * Set the attribute `aria-label` on the system arguments. E.g. `Primer::HellipButton.new("aria-label": "Expand next part")`
  class HellipButton < Primer::Component
    # @example Default
    #   <%= render(Primer::HellipButton.new("aria-label": "No effect")) %>
    #
    # @example Inline
    #   <%= render(Primer::HellipButton.new(inline: true, "aria-label": "No effect")) %>
    #
    # @example Styling the button
    #   <%= render(Primer::HellipButton.new(p: 1, classes: "custom-class", "aria-label": "No effect")) %>
    #
    # @param inline [Boolean] Whether or not the button is inline.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(inline: false, **system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)

      validate_aria_label

      @system_arguments[:tag] = :button
      @system_arguments[:"aria-expanded"] = false
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "inline" => inline
      )
    end

    def call
      render(Primer::Beta::BaseButton.new(**@system_arguments)) { "&hellip;".html_safe }
    end
  end
end
