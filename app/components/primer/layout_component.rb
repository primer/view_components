# frozen_string_literal: true

module Primer
  # Use Layout to build a main/sidebar layout.
  class LayoutComponent < Primer::Component
    with_content_areas :main, :sidebar

    DEFAULT_SIDE = :right
    ALLOWED_SIDES = [DEFAULT_SIDE, :left].freeze

    MAX_COL = 12
    DEFAULT_SIDEBAR_COL = 3
    ALLOWED_SIDEBAR_COLS = (1..(MAX_COL - 1)).to_a.freeze

    # @example Default
    #   <%= render(Primer::LayoutComponent.new) do |component| %>
    #     <% component.with(:sidebar) { "Sidebar" } %>
    #     <% component.with(:main) { "Main" } %>
    #   <% end %>
    #
    # @example Left sidebar
    #   <%= render(Primer::LayoutComponent.new(side: :left)) do |component| %>
    #     <% component.with(:sidebar) { "Sidebar" } %>
    #     <% component.with(:main) { "Main" } %>
    #   <% end %>
    #
    # @param responsive [Boolean] Whether to collapse layout to a single column at smaller widths.
    # @param side [Symbol] Which side to display the sidebar on. <%= one_of(Primer::LayoutComponent::ALLOWED_SIDES) %>
    # @param sidebar_col [Integer] Sidebar column width.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(responsive: false, side: DEFAULT_SIDE, sidebar_col: DEFAULT_SIDEBAR_COL, **system_arguments)
      @system_arguments = system_arguments
      @side = fetch_or_fallback(ALLOWED_SIDES, side, DEFAULT_SIDE)
      @responsive = responsive
      @system_arguments[:classes] = class_names(
        "gutter-condensed gutter-lg",
        @system_arguments[:classes]
      )
      @system_arguments[:direction] = responsive ? [:column, nil, :row] : nil

      @sidebar_col = fetch_or_fallback(ALLOWED_SIDEBAR_COLS, sidebar_col, DEFAULT_SIDEBAR_COL)
      @main_col = MAX_COL - @sidebar_col
    end
  end
end
