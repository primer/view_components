# frozen_string_literal: true

module Primer
  module Alpha
    # `Tooltip` only appears on mouse hover or keyboard focus and contain a label or description text. Use tooltips sparingly and as a last resort.
    # Use tooltips as a last resort. Please consider [Tooltips alternatives](https://primer.style/design/accessibility/tooltip-alternatives).
    #
    # When using a tooltip, follow the provided guidelines to avoid accessibility issues:
    # - Tooltips should contain only **non-essential text**. Tooltips can easily be missed and are not accessible on touch devices so never use tooltips to convey critical information.
    # - `Tooltip` should be rendered through the API of <%= link_to_component(Primer::ButtonComponent)%>, <%= link_to_component(Primer::LinkComponent)%>, or <%= link_to_component(Primer::IconButton)%>. Avoid using `Tooltip` a standalone component unless absolutely necessary (and **only** on interactive elements).
    # @accessibility
    #   - Tooltip text must be brief and concise whether it is a label or a description.
    #   - Tooltip can only hold string content.
    #   - **Never set tooltips on static, non-interactive elements** like `span` or `div`. Tooltips should only be used on interactive elements like buttons or links to avoid excluding keyboard-only users
    #   and screen reader users. Use of tooltip through <%= link_to_component(Primer::ButtonComponent) %>, <%= link_to_component(Primer::LinkComponent) %>, or <%= link_to_component(Primer::IconButton) %> will guarantee this.
    #   - If you must use `Tooltip` as a standalone component, place it adjacent after the trigger element in the DOM. This allows screen reader users to navigate to and copy the tooltip
    #   content.
    #   ### Which type should I set?
    #   Semantically, a tooltip will either act an accessible name or an accessible description for the element that it is associated with resulting in either a
    #   `aria-labelledby` or an `aria-describedby` association. The `type` drastically changes semantics and screen reader behavior so follow these guidelines carefully:
    #   - When there is already a visible label text on the trigger element, the tooltip is likely intended be supplementary, so set `type: :description`.
    #   The majority of tooltips will fall under this category.
    #   - When there is no visible text on the trigger element and the tooltip content is appropriate as a label for the element, set `type: :label`.
    #   `label` type is usually only appropriate for an icon-only control.
    class Tooltip < Primer::Component
      DIRECTION_DEFAULT = :s
      DIRECTION_OPTIONS = [DIRECTION_DEFAULT, :n, :e, :w, :ne, :nw, :se, :sw].freeze

      TYPE_FALLBACK = :description
      TYPE_OPTIONS = [:label, :description].freeze
      # @example As a supplementary description for a button
      #   @description
      #     In this example, the button has a visible label text, "Save". `type: :description` is set because the tooltip content is supplementary.
      #     A screen reader user who encounters this button will hear the accessible name, "Save" followed by the accessible description, "This will immediately impact all organization members".
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "save-button")) do |c| %>
      #       <% c.with_tooltip(text: "This will immediately impact all organization members", type: :description, direction: :ne) %>
      #       Save
      #     <% end %>
      # @example As a label for an `IconButton`
      #   @description
      #     An `IconButton` of `tag: :button` and `tag: :a` will render a tooltip using the `aria-label` content by default. While tooltips should generally be avoided, a tooltip on an `IconButton`
      #     has usability benefits because it provides a textual label for sighted users.
      #     A screen reader user who encounters the following button will hear the accessible name, "Bold".
      #   @code
      #     <%= render(Primer::IconButton.new(id: "bold-button-0", icon: :bold, "aria-label": "Bold")) %>
      # @example As a supplementary description for an `IconButton`
      #   @description
      #     If you want to provide a description for the `IconButton`, set both `aria-label` and `aria-description` text. The tooltip will use the `aria-description` text.
      #     A screen reader user who encounters the following button will hear the accessible name "Search", followed by the accessible description "Use keywords like 'repo:' and 'org:' in your query".
      #   @code
      #     <%= render(Primer::IconButton.new(id: "search-button", icon: :search, "aria-label": "Search", "aria-description": "Use keywords like 'repo:' and 'org:' in your query")) %>
      #
      # @example With direction
      #   @description
      #     Set direction of tooltip with `direction`. The tooltip is responsive and will automatically adjust direction to avoid cutting off.
      #   @code
      #     <%= render(Primer::ButtonComponent.new(id: "North", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a North-facing tooltip, and is responsive.", type: :description, direction: :n) %>
      #       North
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "South", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a South-facing tooltip, and is responsive.", type: :description, direction: :s) %>
      #       South
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "East", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a East-facing tooltip, and is responsive.", type: :description, direction: :e) %>
      #       East
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "West", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a West-facing tooltip, and is responsive.", type: :description, direction: :w) %>
      #       West
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "Northwest", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a Northwest-facing tooltip, and is responsive.", type: :description, direction: :nw) %>
      #       Northwest
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "Southwest", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a Southwest-facing tooltip, and is responsive.", type: :description, direction: :sw) %>
      #       Southwest
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "Northeast", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a Northeast-facing tooltip, and is responsive.", type: :description, direction: :ne) %>
      #       Northeast
      #     <% end %>
      #     <%= render(Primer::ButtonComponent.new(id: "Southeast", m: 2)) do |c| %>
      #       <% c.with_tooltip(text: "This is a Southeast-facing tooltip, and is responsive.", type: :description, direction: :se) %>
      #       Southeast
      #     <% end %>
      # @example Directly using `Tooltip`
      #   @description
      #     When you have a valid tooltip usecase for an interactive element that is not one of the supported components, you may need to use the `Tooltip` component directly.
      #     The tooltip should be placed directly adjacent after the element you are associating it with.
      #     The tooltip is absolutely positioned so ensure there is a wrapper with `position: relative` to avoid positioning issues.
      #   @code
      #     <div style="position: relative;">
      #       <button type="button" id="test-button">Test</button>
      #       <%= render(Primer::Alpha::Tooltip.new(for_id: "test-button", type: :description, text: "This tooltip should take up the full width", direction: :ne)) %>
      #     </div>
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
        @system_arguments[:for] = for_id
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
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
