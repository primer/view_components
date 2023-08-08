# frozen_string_literal: true

module Primer
  # Use `Layout` to build a main/sidebar layout.
  class LayoutComponent < Primer::Component
    status :deprecated

    # The main content
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :main, lambda { |**system_arguments|
      deny_tag_argument(**system_arguments)
      system_arguments[:classes] = class_names("flex-shrink-0", system_arguments[:classes])
      system_arguments[:col] = (@responsive ? [12, nil, @main_col] : @main_col)
      system_arguments[:mb] = (@responsive ? [4, nil, 0] : nil)

      Primer::BaseComponent.new(tag: :div, **system_arguments)
    }

    # The sidebar content
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :sidebar, lambda { |**system_arguments|
      system_arguments[:classes] = class_names("flex-shrink-0", system_arguments[:classes])
      system_arguments[:col] = (@responsive ? [12, nil, @sidebar_col] : @sidebar_col)

      if @side == :left
        system_arguments[:mb] = (@responsive ? [4, nil, 0] : nil)
      end

      Primer::BaseComponent.new(tag: :div, **system_arguments)
    }

    DEFAULT_SIDE = :right
    ALLOWED_SIDES = [DEFAULT_SIDE, :left].freeze

    MAX_COL = 12
    DEFAULT_SIDEBAR_COL = 3
    ALLOWED_SIDEBAR_COLS = (1..(MAX_COL - 1)).to_a.freeze

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
      @system_arguments[:display] = :flex
      @system_arguments[:tag] = :div

      @sidebar_col = fetch_or_fallback(ALLOWED_SIDEBAR_COLS, sidebar_col, DEFAULT_SIDEBAR_COL)
      @main_col = MAX_COL - @sidebar_col
    end
  end
end
