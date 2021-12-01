# frozen_string_literal: true

module Primer
  module Beta
    # `Layout` provides foundational patterns for responsive pages.
    # `Layout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.
    #  On smaller screens, `Layout` uses vertically stacked rows to display content.
    #
    # `Layout` flows as both column, when there's enough horizontal space to render both `Main` and `Pane`side-by-side (on a desktop of tablet device, per instance);
    # or it flows as a row, when `Main` and `Pane` are stacked vertically (e.g. on a mobile device).
    # `Layout` should always work in any screen size.
    #
    # @accessibility
    #   Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
    #   `main` or `sidebar` comes first in code. The code order won’t affect the visual position.
    class Layout < Primer::Component
      WRAPPER_SIZING_DEFAULT = :fluid
      WRAPPER_SIZING_OPTIONS = [WRAPPER_SIZING_DEFAULT, :md, :lg, :xl].freeze

      OUTER_SPACING_DEFAULT = :none
      OUTER_SPACING_MAPPINGS = {
        OUTER_SPACING_DEFAULT => "",
        :normal => "LayoutBeta--outer-spacing-normal",
        :condensed => "LayoutBeta--outer-spacing-condensed"
      }.freeze
      OUTER_SPACING_OPTIONS = OUTER_SPACING_MAPPINGS.keys.freeze

      INNER_SPACING_DEFAULT = :none
      INNER_SPACING_MAPPINGS = {
        INNER_SPACING_DEFAULT => "",
        :normal => "LayoutBeta--inner-spacing-normal",
        :condensed => "LayoutBeta--inner-spacing-condensed"
      }.freeze
      INNER_SPACING_OPTIONS = INNER_SPACING_MAPPINGS.keys.freeze

      COLUMN_GAP_DEFAULT = :none
      COLUMN_GAP_MAPPINGS = {
        COLUMN_GAP_DEFAULT => "",
        :normal => "LayoutBeta--column-gap-normal",
        :condensed => "LayoutBeta--column-gap-condensed"
      }.freeze
      COLUMN_GAP_OPTIONS = COLUMN_GAP_MAPPINGS.keys.freeze

      ROW_GAP_DEFAULT = :none
      ROW_GAP_MAPPINGS = {
        ROW_GAP_DEFAULT => "",
        :normal => "LayoutBeta--row-gap-normal",
        :condensed => "LayoutBeta--row-gap-condensed"
      }.freeze
      ROW_GAP_OPTIONS = ROW_GAP_MAPPINGS.keys.freeze

      RESPONSIVE_BEHAVIOR_DEFAULT = :flow_vertical
      RESPONSIVE_BEHAVIOR_MAPPINGS = {
        RESPONSIVE_BEHAVIOR_DEFAULT => "LayoutBeta--responsive-flowVertical",
        :split_as_pages => "LayoutBeta--responsive-splitAsPages"
      }.freeze
      RESPONSIVE_BEHAVIOR_OPTIONS = RESPONSIVE_BEHAVIOR_MAPPINGS.keys.freeze

      PANE_WIDTH_DEFAULT = :default
      PANE_WIDTH_MAPPINGS = {
        PANE_WIDTH_DEFAULT => "",
        :narrow => "LayoutBeta--pane-width-narrow",
        :wide => "LayoutBeta--pane-width-wide"
      }.freeze
      PANE_WIDTH_OPTIONS = PANE_WIDTH_MAPPINGS.keys.freeze

      PANE_POSITION_DEFAULT = :start
      PANE_POSITION_MAPPINGS = {
        PANE_POSITION_DEFAULT => "LayoutBeta--pane-position-start",
        :end => "LayoutBeta--pane-position-end"
      }.freeze
      PANE_POSITION_OPTIONS = PANE_POSITION_MAPPINGS.keys.freeze

      PANE_DIVIDER_DEFAULT = :start
      PANE_DIVIDER_MAPPINGS = {
        PANE_DIVIDER_DEFAULT => "LayoutBeta--pane-position-start",
        :end => "LayoutBeta--pane-position-start"
      }.freeze
      PANE_DIVIDER_OPTIONS = PANE_DIVIDER_MAPPINGS.keys.freeze

      # The layout's main content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::Layout::Main::WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :main, "Primer::Beta::Layout::Main"

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::Layout::SIDEBAR_WIDTH_OPTIONS) %>
      # @param col_placement [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::Layout::SIDEBAR_COL_PLACEMENT_OPTIONS) %>
      # @param row_placement [Symbol] Pane placement when `Layout` is in row mode. <%= one_of(Primer::Beta::Layout::SIDEBAR_ROW_PLACEMENT_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane, lambda { |
        width: PANE_WIDTH_DEFAULT,
        position: PANE_POSITION_DEFAULT,
        sticky: false,
        divider: false,
        **system_arguments
      |
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          PANE_POSITION_MAPPINGS[fetch_or_fallback(PANE_POSITION_OPTIONS, position, PANE_POSITION_DEFAULT)],
          PANE_WIDTH_MAPPINGS[fetch_or_fallback(PANE_WIDTH_OPTIONS, width, PANE_WIDTH_DEFAULT)],
          { "LayoutBeta--pane-divider" => divider },
          { "LayoutBeta--pane-is-sticky" => sticky }
        )

        Primer::Beta::Layout::Pane.new(**system_arguments)
      }

      # The layout's header.
      #
      # @param divider [Boolean] Whether to show a header divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `header` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :header, lambda { |
        divider: false, **header_system_arguments
      |
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "LayoutBeta--has-header",
          "LayoutBeta--header-divider" => divider
        )

        header_system_arguments[:classes] = class_names(
          header_system_arguments[:classes],
          "LayoutBeta-header"
        )

        Primer::Beta::Layout::Bookend.new(divider: divider, **header_system_arguments)
      }

      # The layout's footer.
      #
      # @param divider [Boolean] Whether to show a header divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `header` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :footer, lambda { |
        divider: false, **footer_system_arguments
      |
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "LayoutBeta--has-footer",
          "LayoutBeta--footer-divider" => divider
        )

        footer_system_arguments[:classes] = class_names(
          footer_system_arguments[:classes],
          "LayoutBeta-footer"
        )

        Primer::Beta::Layout::Bookend.new(divider: divider, **footer_system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Beta::Layout.new) do |c| %>
      #     <% c.main(border: true) { "Main" } %>
      #     <% c.sidebar(border: true) { "Pane" } %>
      #   <% end %>
      #
      # @example Main widths
      #
      #   @description
      #     When `full`, the main column will stretch to cover all the available width.
      #     Otherwise, the main column will try to be centered in the screen; it may appear aligned to the left when there isn't enough space.
      #
      #     Use smaller maximum widths in the main column to facilitate interface scanning and reading.
      #
      #     When flowing as a row, `Main` takes the full width.
      #
      #   @code
      #     <%= render(Primer::Beta::Layout.new) do |c| %>
      #       <% c.main(width: :full, border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(width: :md, border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(width: :lg, border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(width: :xl, border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane widths
      #
      #   @description
      #     Sets the sidebar width. The width is predetermined according to the breakpoint instead of it being percentage-based.
      #
      #     - `default`: [md: 256px, lg: 296px, xl: 320px]
      #     - `narrow`: [md: 240px, lg: 256px, xl: 296px]
      #     - `wide`: [md: 296px, lg: 320px, xl: 344px]
      #
      #     When flowing as a row, `Pane` takes the full width.
      #
      #   @code
      #     <%= render(Primer::Beta::Layout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(width: :default, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(width: :narrow, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(width: :wide, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane placement
      #
      #   @description
      #     Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.
      #
      #   @code
      #     <%= render(Primer::Beta::Layout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(col_placement: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new( mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(col_placement: :end, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane placement as row
      #
      #   @description
      #     When flowing as a row, whether the sidebar is rendered first or last in the layout, or, if it's entirely hidden from the user.
      #
      #     When `hidden`, make sure the experience is not degraded on smaller screens, and the user can still access the sidebar content somehow.
      #     For instance, the user may not see a Settings navigation sidebar when drilled down on a page, but they can still navigate to the Settings
      #     landing page to interact with the local navigation.
      #
      #   @code
      #     <%= render(Primer::Beta::Layout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(row_placement: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(row_placement: :end, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(row_placement: :none, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Changing when to render `Layout` as columns
      #
      #   @description
      #     You can specify when the `Layout` should change from rows into columns.
      #     Any screen size before this breakpoint will render the `Layout` in stacked rows.
      #
      #   @code
      #     <%= render(Primer::Beta::Layout.new(stacking_breakpoint: :sm)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(stacking_breakpoint: :md, mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::Layout.new(stacking_breakpoint: :lg, mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.sidebar(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @param wrapper_sizing [Symbol] The size of the container wrapping `Layout`. <%= one_of(Primer::Beta::Layout::WRAPPER_SIZING_OPTIONS) %>
      # @param outer_spacing [Symbol] Sets wrapper margins surrounding the component to distance itself from the viewport edges. <%= one_of(Primer::Beta::Layout::SPACING_OPTIONS) %>
      # @param inner_spacing [Symbol] Sets padding to regions individually. <%= one_of(Primer::Beta::Layout::SPACING_OPTIONS) %>
      # @param column_gap [Symbol] Sets gap between columns. <%= one_of(Primer::Beta::Layout::SPACING_OPTIONS) %>
      # @param row_gap [Symbol] Sets the gap below the header and above the footer. <%= one_of(Primer::Beta::Layout::SPACING_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        wrapper_sizing: WRAPPER_SIZING_DEFAULT,
        outer_spacing: OUTER_SPACING_DEFAULT,
        inner_spacing: INNER_SPACING_DEFAULT,
        column_gap: COLUMN_GAP_DEFAULT,
        row_gap: ROW_GAP_DEFAULT,
        responsive_behavior: RESPONSIVE_BEHAVIOR_DEFAULT,
        **system_arguments
      )
        @wrapper_sizing = fetch_or_fallback(WRAPPER_SIZING_OPTIONS, wrapper_sizing, WRAPPER_SIZING_DEFAULT)

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "LayoutBeta",
          OUTER_SPACING_MAPPINGS[fetch_or_fallback(OUTER_SPACING_OPTIONS, outer_spacing, OUTER_SPACING_DEFAULT)],
          INNER_SPACING_MAPPINGS[fetch_or_fallback(INNER_SPACING_OPTIONS, inner_spacing, INNER_SPACING_DEFAULT)],
          COLUMN_GAP_MAPPINGS[fetch_or_fallback(COLUMN_GAP_OPTIONS, column_gap, COLUMN_GAP_DEFAULT)],
          ROW_GAP_MAPPINGS[fetch_or_fallback(ROW_GAP_OPTIONS, row_gap, ROW_GAP_DEFAULT)],
          RESPONSIVE_BEHAVIOR_MAPPINGS[fetch_or_fallback(RESPONSIVE_BEHAVIOR_OPTIONS, responsive_behavior, RESPONSIVE_BEHAVIOR_DEFAULT)],
          system_arguments[:classes]
        )
      end

      def render?
        main.present? && pane.present?
      end

      # The layout's main content.
      class Main < Primer::Component
        WIDTH_DEFAULT = :full
        WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

        # @param width [Symbol] <%= one_of(Primer::Beta::Layout::Main::WIDTH_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: TAG_DEFAULT, width: WIDTH_DEFAULT, **system_arguments)
          @width = fetch_or_fallback(WIDTH_OPTIONS, width, WIDTH_DEFAULT)

          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "LayoutBeta-content",
            system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            if @width == :full
              content
            else
              render(Primer::BaseComponent.new(tag: :div, classes: "Layout-main-centered-#{@width}")) do
                render(Primer::BaseComponent.new(tag: :div, container: @width)) do
                  content
                end
              end
            end
          end
        end
      end

      # The layout's header or footer content.
      class Bookend < Primer::Component
        RESPONSIVE_DIVIDER_DEFAULT = :none
        RESPONSIVE_DIVIDER_MAPPINGS = {
          RESPONSIVE_DIVIDER_DEFAULT => "",
          :line => "LayoutBeta-region--line-divider",
          :shallow => "LayoutBeta-region--shallow-divider"
        }.freeze
        RESPONSIVE_DIVIDER_OPTIONS = RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze
        # @param width [Symbol] <%= one_of(Primer::Beta::Layout::Main::WIDTH_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(responsive_divider: RESPONSIVE_DIVIDER_DEFAULT, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            "LayoutBeta-region",
            RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, RESPONSIVE_DIVIDER_DEFAULT)],
          )
        end

        def call
          render(Primer::BaseComponent.new(tag: :div, **@system_arguments)) { content }
        end
      end

      # The layout's sidebar content.
      class Pane < Primer::Component
        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :aside, :nav, :section].freeze

        def initialize(tag: TAG_DEFAULT, **system_arguments)
          @system_arguments = system_arguments

          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "LayoutBeta-pane",
            @system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
