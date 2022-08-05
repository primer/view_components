# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` only appears on mouse hover or keyboard focus and contain a label or description text.
    # Use tooltips sparingly and as a last resort.
    #
    # When using a tooltip, follow the provided guidelines to avoid accessibility issues.
    #
    # - Tooltip text should be brief and to the point. The tooltip content must be a string.
    # - Tooltips should contain only **non-essential text**. Tooltips can easily be missed and are not accessible on touch devices so never
    #  use tooltips to convey critical information.
    #
    # @accessibility
    #   - **Never set tooltips on static elements.** Tooltips should only be used on interactive elements like buttons or links to avoid excluding keyboard-only users
    #   and screen reader users.
    #   - Place `Tooltip` adjacent after its trigger element in the DOM. This allows screen reader users to navigate to and copy the tooltip
    #   content.
    #   ### Which `type` should I set?
    #   Setting `:description` establishes an `aria-describedby` relationship, while `:label` establishes an `aria-labelledby` relationship between the trigger element and the tooltip,
    #
    #   The `type` drastically changes semantics and screen reader behavior so follow these guidelines carefully:
    #   - When there is already a visible label text on the trigger element, the tooltip is likely intended to supplement the existing text, so set `type: :description`.
    #   The majority of tooltips will fall under this category.
    #   - When there is no visible text on the trigger element and the tooltip content is appropriate as a label for the element, set `type: :label`.
    #   This type is usually only appropriate for an icon-only control.
    class Tooltip < Primer::Component
      DIRECTION_DEFAULT = :s
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :n, :e, :w, :ne, :nw, :se, :sw].freeze

      TYPE_FALLBACK = :description
      TYPE_OPTIONS = [:label, :description].freeze
      # @example As a description for an icon-only button
      #   @description
      #     If the tooltip content provides supplementary description, set `type: :description` to establish an `aria-describedby` relationship.
      #     The trigger element should also have a _concise_ accessible label via `aria-label`.
      #   @code
      #     <%= render(Primer::IconButton.new(id: "bold-button-0", icon: :bold, "aria-label": "Bold")) %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "bold-button-0", type: :description, text: "Add bold text", direction: :ne)) %>
      # @example As a label for an icon-only button
      #   @description
      #     If the tooltip labels the icon-only button, set `type: :label`. This tooltip content becomes the accessible name for the button.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "like-button")) { "👍" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "like-button", type: :label, text: "Like", direction: :n)) %>
      #
      # @example As a description for a button with visible label
      #   @description
      #     If the button already has visible label text, the tooltip content is likely supplementary so set `type: :description`.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "save-button", scheme: :primary)) { "Save" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "save-button", type: :description, text: "This will immediately impact all organization members", direction: :ne)) %>
      # @example With direction
      #   @description
      #     Set direction of tooltip with `direction`. The tooltip is responsive and will automatically adjust direction to avoid cutting off.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "North", m: 2)) { "North" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "North", type: :description, text: "This is a North-facing tooltip, and is responsive.", direction: :n)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "South", m: 2)) { "South" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "South", type: :description, text: "This is a South-facing tooltip and is responsive.", direction: :s)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "East", m: 2)) { "East" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "East", type: :description, text: "This is a East-facing tooltip and is responsive.", direction: :e)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "West", m: 2)) { "West" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "West", type: :description, text: "This is a West-facing tooltip and is responsive.", direction: :w)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "Northeast", m: 2)) { "Northeast" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "Northeast", type: :description, text: "This is a Northeast-facing tooltip and is responsive.", direction: :ne)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "Southeast", m: 2)) { "Southeast" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "Southeast", type: :description, text: "This is a Southeast-facing tooltip and is responsive.", direction: :se)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "Northwest", m: 2)) { "Northwest" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "Northwest", type: :description, text: "This is a Northwest-facing tooltip and is responsive.", direction: :nw)) %>
      #     <%= render(Primer::ButtonComponent.new(id: "Southwest", m: 2)) { "Southwest" } %>
      #     <%= render(Primer::Alpha::Tooltip.new(for_id: "Southwest", type: :description, text: "This is a Southwest-facing tooltip and is responsive.", direction: :sw)) %>
      # @example With relative parent
      #   @description
      #     When the tooltip and trigger element have a parent container with `relative: position`, it should not affect width of the tooltip.
      #   @code
      #     <span style="position: relative;">
      #       <%= render(Primer::ButtonComponent.new(id: "test-button", scheme: :primary)) { "Test" } %>
      #       <%= render(Primer::Alpha::Tooltip.new(for_id: "test-button", type: :description, text: "This tooltip should take up the full width", direction: :ne)) %>
      #     </span>
      # @param for_id [String] The ID of the element that the tooltip should be attached to.
      # @param type [Symbol] <%= one_of(Primer::Alpha::Tooltip::TYPE_OPTIONS) %>
      # @param direction [Symbol] <%= one_of(Primer::Alpha::Tooltip::DIRECTION_OPTIONS) %>
      # @param text [String] The text content of the tooltip. This should be brief and no longer than a sentence.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(type:, for_id:, text:, direction: DIRECTION_DEFAULT, **system_arguments)
        raise TypeError, "tooltip text must be a string" unless text.is_a?(String)

        @text = text
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"tool-tip"
        @system_arguments[:style] = join_style_arguments(@system_arguments[:style], "visibility: hidden")
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
