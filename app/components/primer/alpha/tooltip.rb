# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` only appears on mouse hover or keyboard focus and contain a label or description text. Use tooltips sparingly and as a last resort.
    # Use tooltips as a last resort. Please consider [Tooltips alternatives](https://primer.style/design/accessibility/tooltip-alternatives).
    #
    # When using a tooltip, follow the provided guidelines to avoid accessibility issues:
    # - Tooltips should contain only **non-essential text**. Tooltips can easily be missed and are not accessible on touch devices so never use tooltips to convey critical information.
    # - `Tooltip` should be rendered through the API of <%= link_to_component(Primer::ButtonComponent)%>, <%= link_to_component(Primer::Beta::Link)%>, or <%= link_to_component(Primer::IconButton)%>. Avoid using `Tooltip` a standalone component unless absolutely necessary (and **only** on interactive elements).
    # - Tooltip text must be brief and concise even when used to display a description.
    # - Tooltips can only hold string content.
    # - Tooltips are not allowed on `disabled` elements because such elements are not keyboard-accessible. If you must set a tooltip on a disabled element, use `aria-disabled="true"` instead and programmatically disable the element.
    # - **Never set tooltips on static, non-interactive elements** like `span` or `div`. Tooltips should only be used on interactive elements like buttons or links to avoid excluding keyboard-only
    # and screen reader users. Use of tooltips through <%= link_to_component(Primer::Beta::Button) %>, <%= link_to_component(Primer::Beta::Link) %>, or <%= link_to_component(Primer::Beta::IconButton) %> will guarantee this.
    # - If you must use `Tooltip` as a standalone component, place it immediately after the trigger element in the DOM. This allows screen reader users to navigate to the tooltip and copy its contents if desired.
    #   content.
    #
    # Semantically, a tooltip will either act an accessible name or an accessible description for the element that it is associated with resulting in either a
    # `aria-labelledby` or an `aria-describedby` association. The `type` drastically changes semantics and screen reader behavior so follow these guidelines carefully:
    # - When there is already a visible label text on the trigger element, the tooltip is likely intended be supplementary, so set `type: :description`.
    # The majority of tooltips will fall under this category.
    # - When there is no visible text on the trigger element and the tooltip content is appropriate as a label for the element, set `type: :label`.
    # `label` type is usually only appropriate for an icon-only control.
    class Tooltip < Primer::Component
      DIRECTION_DEFAULT = :s
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :n, :e, :w, :ne, :nw, :se, :sw].freeze

      TYPE_FALLBACK = :description
      TYPE_OPTIONS = [:label, :description].freeze

      # @param for_id [String] The ID of the element that the tooltip should be attached to.
      # @param type [Symbol] <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
      # @param direction [Symbol] <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
      # @param text [String] The text content of the tooltip. This should be brief and no longer than a sentence.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type:, for_id:, text:, direction: DIRECTION_DEFAULT, **system_arguments)
        raise TypeError, "tooltip text must be a string" unless text.is_a?(String)

        @text = text
        @system_arguments = system_arguments
        @system_arguments[:id] ||= self.class.generate_id
        @system_arguments[:tag] = :"tool-tip"
        @system_arguments[:for] = for_id
        @system_arguments[:popover] = "manual"
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "sr-only"
        )
        @system_arguments[:position] = :absolute
        @system_arguments[:"data-direction"] = fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT).to_s
        @system_arguments[:"data-type"] = fetch_or_fallback(TYPE_OPTIONS, type, TYPE_FALLBACK).to_s
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { @text }
      end
    end
  end
end
