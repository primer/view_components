# frozen_string_literal: true

module Primer
  module Alpha
    # `Layout` provides foundational patterns for responsive pages.
    # `Layout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.
    #  On smaller screens, `Layout` uses vertically stacked rows to display content.
    #
    # `Layout` flows as both column, when there's enough horizontal space to render both `Main` and `Sidebar`side-by-side (on a desktop of tablet device, per instance);
    # or it flows as a row, when `Main` and `Sidebar` are stacked vertically (e.g. on a mobile device).
    # `Layout` should always work in any screen size.
    #
    # @accessibility
    #   Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
    #   `main` or `sidebar` comes first in code. The code order won’t affect the visual position.
    class Layout < Primer::Component
      status :alpha

      FIRST_IN_SOURCE_DEFAULT = :sidebar
      FIRST_IN_SOURCE_OPTIONS = [FIRST_IN_SOURCE_DEFAULT, :main].freeze

      SIDEBAR_COL_PLACEMENT_DEFAULT = :start
      SIDEBAR_COL_PLACEMENT_OPTIONS = [SIDEBAR_COL_PLACEMENT_DEFAULT, :end].freeze

      GUTTER_DEFAULT = :default
      GUTTER_MAPPINGS = {
        :none => "Layout--gutter-none",
        :condensed => "Layout--gutter-condensed",
        :spacious => "Layout--gutter-spacious",
        GUTTER_DEFAULT => ""
      }.freeze
      GUTTER_OPTIONS = GUTTER_MAPPINGS.keys.freeze

      STACKING_BREAKPOINT_DEFAULT = :md
      STACKING_BREAKPOINT_MAPPINGS = {
        :sm => "",
        STACKING_BREAKPOINT_DEFAULT => "Layout--flowRow-until-md",
        :lg => "Layout--flowRow-until-lg"
      }.freeze
      STACKING_BREAKPOINT_OPTIONS = STACKING_BREAKPOINT_MAPPINGS.keys.freeze

      SIDEBAR_ROW_PLACEMENT_DEFAULT = :start
      SIDEBAR_ROW_PLACEMENT_OPTIONS = [SIDEBAR_ROW_PLACEMENT_DEFAULT, :end, :none].freeze

      SIDEBAR_WIDTH_DEFAULT = :default
      SIDEBAR_WIDTH_MAPPINGS = {
        SIDEBAR_WIDTH_DEFAULT => "",
        :narrow => "Layout--sidebar-narrow",
        :wide => "Layout--sidebar-wide"
      }.freeze
      SIDEBAR_WIDTH_OPTIONS = SIDEBAR_WIDTH_MAPPINGS.keys.freeze

      # The layout's main content.
      #
      # @param width [Symbol] <%= one_of(Primer::Alpha::Layout::Main::WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :main, "Primer::Alpha::Layout::Main"

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Alpha::Layout::SIDEBAR_WIDTH_OPTIONS) %>
      # @param col_placement [Symbol] Sidebar placement when `Layout` is in column modes. <%= one_of(Primer::Alpha::Layout::SIDEBAR_COL_PLACEMENT_OPTIONS) %>
      # @param row_placement [Symbol] Sidebar placement when `Layout` is in row mode. <%= one_of(Primer::Alpha::Layout::SIDEBAR_ROW_PLACEMENT_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :sidebar, lambda { |
        width: SIDEBAR_WIDTH_DEFAULT,
        col_placement: SIDEBAR_COL_PLACEMENT_DEFAULT,
        row_placement: SIDEBAR_ROW_PLACEMENT_DEFAULT,
        **system_arguments
      |
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Layout--sidebarPosition-#{fetch_or_fallback(SIDEBAR_COL_PLACEMENT_OPTIONS, col_placement, SIDEBAR_COL_PLACEMENT_DEFAULT)}",
          "Layout--sidebarPosition-flowRow-#{fetch_or_fallback(SIDEBAR_ROW_PLACEMENT_OPTIONS, row_placement, SIDEBAR_ROW_PLACEMENT_DEFAULT)}",
          SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, width, SIDEBAR_WIDTH_DEFAULT)]
        )

        Primer::Alpha::Layout::Sidebar.new(**system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Alpha::Layout.new) do |component| %>
      #     <% component.with_main(border: true) { "Main" } %>
      #     <% component.with_sidebar(border: true) { "Sidebar" } %>
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
      #     <%= render(Primer::Alpha::Layout.new) do |component| %>
      #       <% component.with_main(width: :full, border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(width: :md, border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(width: :lg, border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(width: :xl, border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #
      # @example Sidebar widths
      #
      #   @description
      #     Sets the sidebar width. The width is predetermined according to the breakpoint instead of it being percentage-based.
      #
      #     - `default`: [md: 256px, lg: 296px, xl: 320px]
      #     - `narrow`: [md: 240px, lg: 256px, xl: 296px]
      #     - `wide`: [md: 296px, lg: 320px, xl: 344px]
      #
      #     When flowing as a row, `Sidebar` takes the full width.
      #
      #   @code
      #     <%= render(Primer::Alpha::Layout.new) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(width: :default, border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(width: :narrow, border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(width: :wide, border: true) { "Sidebar" } %>
      #     <% end %>
      #
      # @example Sidebar placement
      #
      #   @description
      #     Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.
      #
      #   @code
      #     <%= render(Primer::Alpha::Layout.new) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(col_placement: :start, border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new( mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(col_placement: :end, border: true) { "Sidebar" } %>
      #     <% end %>
      #
      # @example Sidebar placement as row
      #
      #   @description
      #     When flowing as a row, whether the sidebar is rendered first or last in the layout, or, if it's entirely hidden from the user.
      #
      #     When `hidden`, make sure the experience is not degraded on smaller screens, and the user can still access the sidebar content somehow.
      #     For instance, the user may not see a Settings navigation sidebar when drilled down on a page, but they can still navigate to the Settings
      #     landing page to interact with the local navigation.
      #
      #   @code
      #     <%= render(Primer::Alpha::Layout.new) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(row_placement: :start, border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(row_placement: :end, border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(row_placement: :none, border: true) { "Sidebar" } %>
      #     <% end %>
      #
      # @example Changing when to render `Layout` as columns
      #
      #   @description
      #     You can specify when the `Layout` should change from rows into columns.
      #     Any screen size before this breakpoint will render the `Layout` in stacked rows.
      #
      #   @code
      #     <%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :sm)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :md, mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #     <%= render(Primer::Alpha::Layout.new(stacking_breakpoint: :lg, mt: 5)) do |component| %>
      #       <% component.with_main(border: true) { "Main" } %>
      #       <% component.with_sidebar(border: true) { "Sidebar" } %>
      #     <% end %>
      #
      # @param stacking_breakpoint [Symbol] When the `Layout` should change from rows into columns. <%= one_of(Primer::Alpha::Layout::STACKING_BREAKPOINT_OPTIONS) %>
      # @param first_in_source [Symbol] Which element to render first in the HTML. This will change the keyboard navigation order. <%= one_of(Primer::Alpha::Layout::FIRST_IN_SOURCE_OPTIONS) %>
      # @param gutter [Symbol] The amount of space between the main section and the sidebar. <%= one_of(Primer::Alpha::Layout::GUTTER_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(stacking_breakpoint: STACKING_BREAKPOINT_DEFAULT, first_in_source: FIRST_IN_SOURCE_DEFAULT, gutter: :default, **system_arguments)
        @first_in_source = fetch_or_fallback(FIRST_IN_SOURCE_OPTIONS, first_in_source, FIRST_IN_SOURCE_OPTIONS)

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "Layout",
          STACKING_BREAKPOINT_MAPPINGS[fetch_or_fallback(STACKING_BREAKPOINT_OPTIONS, stacking_breakpoint, STACKING_BREAKPOINT_DEFAULT)],
          GUTTER_MAPPINGS[fetch_or_fallback(GUTTER_OPTIONS, gutter, GUTTER_DEFAULT)],
          system_arguments[:classes]
        )
      end

      def render?
        main? && sidebar?
      end

      # The layout's main content.
      class Main < Primer::Component
        WIDTH_DEFAULT = :full
        WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

        # @param width [Symbol] <%= one_of(Primer::Alpha::Layout::Main::WIDTH_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: TAG_DEFAULT, width: WIDTH_DEFAULT, **system_arguments)
          @width = fetch_or_fallback(WIDTH_OPTIONS, width, WIDTH_DEFAULT)

          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "Layout-main",
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

      # The layout's sidebar content.
      class Sidebar < Primer::Component
        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :aside, :nav, :section].freeze

        def initialize(tag: TAG_DEFAULT, **system_arguments)
          @system_arguments = system_arguments

          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "Layout-sidebar",
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
