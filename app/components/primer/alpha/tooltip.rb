# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` contains text that labels or describes an element, and only appears on mouse hover or keyboard focus.
    # Since tooltips are not visible by default, it can easily be missed by the user. Additionally, it can cause a myriad
    # of accessibility issues when used incorrectly so use sparingly and follow the provided guidelines.
    #
    # - **Never set tooltips on static elements.** They should only be used on interactive elements like buttons or links.
    # - Tooltip text should be brief and to the point. This component only allows strings as tooltip content.
    # - Tooltips should contain only **non-essential text**. Tooltips are not accessible on touch devices so never use tooltips to convey
    #   critical information.
    #
    # @accessibility
    #   - When `type: :label` is set, an `aria-labelledby` relationship is created between the tooltip and the tooltip trigger element.
    #     When `type: :description` is set, an `aria-describedby` relationship is created.
    #   - Place `Tooltip` adjacent after its trigger element in the DOM. This allows screen reader users to navigate to and copy the tooltip
    #     content versus if the tooltip element is placed at the end of the DOM.
    class Tooltip < Primer::Component
      DIRECTION_DEFAULT = :s
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :n, :e, :w, :ne, :nw, :se, :sw].freeze

      TYPE_FALLBACK = :description
      TYPE_OPTIONS = [:label, :description].freeze
      # @example As a description for an icon-only button
      #   @description
      #     If the tooltip content acts as a supplementary description, set `type: :description` to
      #     establish an `aria-describedby` relationship. Ensure that the element also has an accessible label via `aria-label`.
      #   @code
      #     <%= render(Primer::IconButton.new(id: "bold-button-0", icon: :bold, "aria-label": "Bold")) %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "bold-button-0", type: :description, text: "Add bold text", direction: :ne)) %>
      # @example As a label for an icon-only button
      #   @description
      #     If the tooltip content acts as a label, set `type: :label` to establish an `aria-labelledby` relationship.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "like-button")) { "👍" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "like-button", type: :label, text: "Like", direction: :n)) %>
      #
      # @example As a description for a button with visible label
      #   @description
      #     When the button already has visible text that acts as a label, it's likely the tooltip content is supplementary so set
      #     `type: :description` to establish an `aria-describedby` relationship.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "save-button", scheme: :primary)) { "Save" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "save-button", type: :description, text: "This will immediately impact all organization members", direction: :ne)) %>
      # @param for_id [String] The ID of the element that the tooltip should be attached to.
      # @param type [Symbol] <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>.
      # @param direction [Symbol] <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
      # @param text [String] The text content of the tooltip. This should be brief and no longer than a sentence.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type:, for_id:, text:, direction: DIRECTION_DEFAULT, **system_arguments)
        raise TypeError, "tooltip text must be a string" unless text.is_a?(String)

        @text = text
        @system_arguments = system_arguments
        @system_arguments[:hidden] = true
        @system_arguments[:tag] = :"tool-tip"
        @system_arguments[:for] = for_id
        @system_arguments[:"data-direction"] = fetch_or_fallback(DIRECTION_OPTIONS, direction, DIRECTION_DEFAULT).to_s
        @system_arguments[:"data-type"] = fetch_or_fallback(TYPE_OPTIONS, type, TYPE_FALLBACK).to_s
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { @text }
      end
      end
    end
  end
