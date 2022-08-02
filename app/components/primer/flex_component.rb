# frozen_string_literal: true

module Primer
  # Use `Flex` to make an element lay out its content using the flexbox model.
  # Before using these utilities, you should be familiar with CSS3 Flexible Box
  # spec. If you are not, check out MDN's guide  [Using CSS Flexible
  # Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox).
  #
  # @deprecated
  #   Use <%= link_to_component(Primer::Box) %> instead.
  #
  #   **Before**:
  #
  #   ```erb
  #   <%%= render Primer::FlexComponent.new(justify_content: :center) %>
  #   <%%= render Primer::FlexComponent.new(inline: true) %>
  #   <%%= render Primer::FlexComponent.new(flex_wrap: true) %>
  #   <%%= render Primer::FlexComponent.new(align_items: :start) %>
  #   <%%= render Primer::FlexComponent.new(direction: :column) %>
  #   ```
  #
  #   **After**:
  #
  #   ```erb
  #   <%%= render Primer::Box.new(display: :flex, justify_content: :center) %>
  #   <%%= render Primer::Box.new(display: :inline_flex) %>
  #   <%%= render Primer::Box.new(display: :flex, flex_wrap: :wrap) %>
  #   <%%= render Primer::Box.new(display: :flex, align_items: :start) %>
  #   <%%= render Primer::Box.new(display: :flex, direction: :column) %>
  #   ```
  class FlexComponent < Primer::Component
    status :deprecated

    JUSTIFY_CONTENT_DEFAULT = nil
    JUSTIFY_CONTENT_MAPPINGS = {
      flex_start: "flex-justify-start",
      flex_end: "flex-justify-end",
      center: "flex-justify-center",
      space_between: "flex-justify-between",
      space_around: "flex-justify-around"
    }.freeze
    JUSTIFY_CONTENT_OPTIONS = [JUSTIFY_CONTENT_DEFAULT, *JUSTIFY_CONTENT_MAPPINGS.keys].freeze

    ALIGN_ITEMS_DEFAULT = nil
    ALIGN_ITEMS_MAPPINGS = {
      start: "flex-items-start",
      end: "flex-items-end",
      center: "flex-items-center",
      baseline: "flex-items-baseline",
      stretch: "flex-items-stretch"
    }.freeze
    ALIGN_ITEMS_OPTIONS = [ALIGN_ITEMS_DEFAULT, *ALIGN_ITEMS_MAPPINGS.keys].freeze

    INLINE_DEFAULT = false
    INLINE_OPTIONS = [INLINE_DEFAULT, true].freeze

    FLEX_WRAP_DEFAULT = nil
    FLEX_WRAP_OPTIONS = [FLEX_WRAP_DEFAULT, true, false].freeze

    DEFAULT_DIRECTION = nil
    ALLOWED_DIRECTIONS = [DEFAULT_DIRECTION, :column, :column_reverse, :row, :row_reverse].freeze

    # @example Default
    #   <%= render(Primer::FlexComponent.new(bg: :subtle)) do %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
    #   <% end %>
    #
    # @example Justify center
    #   <%= render(Primer::FlexComponent.new(justify_content: :center, bg: :subtle)) do %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
    #   <% end %>
    #
    # @example Align end
    #   <%= render(Primer::FlexComponent.new(align_items: :end, bg: :subtle)) do %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
    #   <% end %>
    #
    # @example Direction column
    #   <%= render(Primer::FlexComponent.new(direction: :column, bg: :subtle)) do %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
    #     <%= render(Primer::Box.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
    #   <% end %>
    #
    # @param justify_content [Symbol] Use this param to distribute space between and around flex items along the main axis of the container. <%= one_of(Primer::FlexComponent::JUSTIFY_CONTENT_OPTIONS) %>
    # @param inline [Boolean] Defaults to false.
    # @param flex_wrap [Boolean] Defaults to nil.
    # @param align_items [Symbol] Use this param to align items on the cross axis. <%= one_of(Primer::FlexComponent::ALIGN_ITEMS_OPTIONS) %>
    # @param direction [Symbol] Use this param to define the orientation of the main axis (row or column). By default, flex items will display in a row. <%= one_of(Primer::FlexComponent::ALLOWED_DIRECTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      justify_content: JUSTIFY_CONTENT_DEFAULT,
      inline: INLINE_DEFAULT,
      flex_wrap: FLEX_WRAP_DEFAULT,
      align_items: ALIGN_ITEMS_DEFAULT,
      direction: nil,
      **system_arguments
    )
      deprecated_component_warning(new_class: Primer::Box, version: "0.0.40")

      @align_items = fetch_or_fallback(ALIGN_ITEMS_OPTIONS, align_items, ALIGN_ITEMS_DEFAULT)
      @justify_content = fetch_or_fallback(JUSTIFY_CONTENT_OPTIONS, justify_content, JUSTIFY_CONTENT_DEFAULT)
      @flex_wrap = fetch_or_fallback(FLEX_WRAP_OPTIONS, flex_wrap, FLEX_WRAP_DEFAULT)

      # Support direction argument that is an array
      @direction =
        if (Array(direction) - ALLOWED_DIRECTIONS).empty?
          direction
        else
          DEFAULT_DIRECTION
        end

      @system_arguments = system_arguments.merge({ direction: @direction }.compact)
      @system_arguments[:classes] = class_names(@system_arguments[:classes], component_class_names)
      @system_arguments[:display] = fetch_or_fallback(INLINE_OPTIONS, inline, INLINE_DEFAULT) ? :inline_flex : :flex
    end

    def call
      render(Primer::Box.new(**@system_arguments)) { content }
    end

    private

    def component_class_names
      out = []
      out << JUSTIFY_CONTENT_MAPPINGS[@justify_content]
      out << ALIGN_ITEMS_MAPPINGS[@align_items]

      out <<
        case @flex_wrap
        when true
          "flex-wrap"
        when false
          "flex-nowrap"
        end

      out.compact.join(" ")
    end
  end
end
