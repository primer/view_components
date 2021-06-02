# frozen_string_literal: true

module Primer
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
    CONTAINER_DEFAULT = :full
    CONTAINER_OPTIONS = [CONTAINER_DEFAULT, :xl, :lg, :md].freeze

    DENSITY_DEFAULT = :none
    DENSITY_MAPPINGS = {
      DENSITY_DEFAULT => 0,
      :compact => 3,
      :normal => [nil, 3, nil, 4],
      :relaxed => [nil, 3, nil, 4, 5]
    }.freeze
    DENSITY_OPTIONS = DENSITY_MAPPINGS.keys.freeze

    SIDEBAR_WIDTH_DEFAULT = :default
    SIDEBAR_WIDTH_MAPPINGS = {
      SIDEBAR_WIDTH_DEFAULT => "",
      :narrow => "Layout--sidebar-narrow",
      :wide => "Layout--sidebar-wide"
    }.freeze
    SIDEBAR_WIDTH_OPTIONS = SIDEBAR_WIDTH_MAPPINGS.keys.freeze

    GUTTER_DEFAULT = :default
    GUTTER_MAPPINGS = {
      GUTTER_DEFAULT => "",
      :none => "Layout--gutter-none",
      :condensed => "Layout--gutter-condensed",
      :spacious => "Layout--gutter-spacious"
    }.freeze
    GUTTER_OPTIONS = GUTTER_MAPPINGS.keys.freeze

    SIDEBAR_PLACEMENT_DEFAULT = :start
    SIDEBAR_PLACEMENT_OPTIONS = [SIDEBAR_PLACEMENT_DEFAULT, :end].freeze

    SIDEBAR_FLOW_ROW_PLACEMENT_DEFAULT = :start
    SIDEBAR_FLOW_ROW_PLACEMENT_OPTIONS = [SIDEBAR_FLOW_ROW_PLACEMENT_DEFAULT, :end, :none].freeze

    FLOW_ROW_UNTIL_DEFAULT = :sm
    FLOW_ROW_UNTIL_MAPPINGS = {
      FLOW_ROW_UNTIL_DEFAULT => "",
      :md => "Layout--flowRow-until-md",
      :lg => "Layout--flowRow-until-lg"
    }.freeze
    FLOW_ROW_UNTIL_OPTIONS = FLOW_ROW_UNTIL_MAPPINGS.keys.freeze

    MAIN_WIDTH_DEFAULT = :full
    MAIN_WIDTH_OPTIONS = [MAIN_WIDTH_DEFAULT, :md, :lg, :xl].freeze

    DIVIDER_FLOW_ROW_VARIANT_DEFAULT = :visible
    DIVIDER_FLOW_ROW_VARIANT_MAPPINGS = {
      DIVIDER_FLOW_ROW_VARIANT_DEFAULT => "",
      :hidden => "Layout-divider--flowRow-hidden",
      :shallow => "Layout-divider--flowRow-shallow"
    }.freeze
    DIVIDER_FLOW_ROW_VARIANT_OPTIONS = DIVIDER_FLOW_ROW_VARIANT_MAPPINGS.keys

    # The layout's main content.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :main, ->(**system_arguments) { Primer::Layout::Main.new(width: @main_width, **system_arguments) }

    # The layout's sidebar.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :sidebar, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "Layout-sidebar",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

    # @example Default
    #
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(border: true) { "Main" } %>
    #     <% c.sidebar(border: true) { "Sidebar" } %>
    #   <% end %>
    #
    # @example With divider
    #
    #   @description
    #     If `gutter` is present, its spacing is presented before and after the divider.
    #
    #   @code
    #     <%= render(Primer::Layout.new(with_divider: true)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Divider variants
    #
    #   <%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :visible)) do |c| %>
    #     <% c.main(border: true) { "Main" } %>
    #     <% c.sidebar(border: true) { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :hidden, mt: 5)) do |c| %>
    #     <% c.main(border: true) { "Main" } %>
    #     <% c.sidebar(border: true) { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(with_divider: true, divider_flow_row_variant: :shallow, mt: 5)) do |c| %>
    #     <% c.main(border: true) { "Main" } %>
    #     <% c.sidebar(border: true) { "Sidebar" } %>
    #   <% end %>
    #
    # @example Sidebar placement
    #
    #   @description
    #     Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.
    #
    #   @code
    #     <%= render(Primer::Layout.new(sidebar_placement: :start)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(sidebar_placement: :end, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
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
    #     <%= render(Primer::Layout.new(sidebar_flow_row_placement: :start)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(sidebar_flow_row_placement: :end, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(sidebar_flow_row_placement: :none, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Sidebar widths
    #
    #   @description
    #     Sets the sidebar width. The width is predetermined according to the breakpoint instead of it being percentage-based.
    #
    #     - default: [md: 256px, lg: 296px, xl: 320px]
    #     - narrow: [md: 240px, lg: 256px, xl: 296px]
    #     - wide: [md: 296px, lg: 320px, xl: 344px]
    #
    #     When flowing as a row, `Sidebar` takes the full width.
    #
    #   @code
    #     <%= render(Primer::Layout.new(sidebar_width: :default)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(sidebar_width: :narrow, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(sidebar_width: :wide, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
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
    #     <%= render(Primer::Layout.new(main_width: :full)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(main_width: :md, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(main_width: :lg, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(main_width: :xl, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Gutters
    #
    #   @description
    #     How much spacing to include between `Main` and `Sidebar` when flowing as columns.
    #
    #     - :default: [md: 16px, lg: 24px]
    #     - :none: 0px
    #     - :condensed 16px
    #     - :spacious [md: 16px, lg: 32px, xl: 40px]
    #
    #   @code
    #     <%= render(Primer::Layout.new(gutter: :default)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(gutter: :none, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(gutter: :condensed, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(gutter: :spacious, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Using containers
    #
    #   @description
    #     If `full`, the `Layout` component is applied edge-to-edge.
    #     Otherwise, the output is wrapped on a `container-**` class that centers `Layout` on the page and limits its maximum width.
    #     See [containers reference](https://primer.style/css/objects/grid#containers) for more details.
    #     When flowing as a row, `Container` always takes the full width.
    #
    #   @code
    #     <%= render(Primer::Layout.new(container: :full)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(container: :xl, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(container: :lg, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(container: :md, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Flow row until
    #
    #   @description
    #     You can specify when the `Layout` should change from column into row.
    #
    #   @code
    #     <%= render(Primer::Layout.new(flow_row_until: :sm)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(flow_row_until: :md, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(flow_row_until: :lg, mt: 5)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Density
    #
    #   @description
    #     Sets the outside margin of the `Layout` component.
    #     - `none`: 0
    #     - `compact`: 16px
    #     - `normal`: [sm: 16px, lg: 24px]
    #     - `relaxed`: [sm: 16px, lg: 24px, xl: 32px]
    #
    #     Use a value other than `none` when `Layout` is a top-level container for the entire page, and `Main` and `Sidebar` don't have custom padding.
    #
    #     When flowing as a row, `margin` always uses `16px` if not set to `none`.
    #
    #   @code
    #     <%= render(Primer::Layout.new(density: :none)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(density: :compact)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(density: :normal)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #     <%= render(Primer::Layout.new(density: :relaxed)) do |c| %>
    #       <% c.main(border: true) { "Main" } %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @example Three column layout
    #
    #   @description
    #     `Layouts` can be nested to create 3-column pages.
    #
    #   @code
    #     <%= render(Primer::Layout.new) do |c| %>
    #       <% c.main(border: true) do %>
    #         <%= render(Primer::Layout.new(sidebar_placement: :end)) do |l| %>
    #           <% l.main(border: true) { "Main" } %>
    #           <% l.sidebar(border: true) { "Metadata" } %>
    #         <% end %>
    #       <% end %>
    #       <% c.sidebar(border: true) { "Sidebar" } %>
    #     <% end %>
    #
    # @param density [Symbol] Margin around the `Layout`.
    # @param container [Symbol] Container to wrap the `Layout` in. <%= one_of(Primer::Layout::CONTAINER_OPTIONS) %>
    # @param gutter [Symbol] Space between `main` and `sidebar`. <%= one_of(Primer::Layout::GUTTER_OPTIONS) %>
    # @param flow_row_until [Symbol] When the `Layout` should change from a row flow into a column flow. <%= one_of(Primer::Layout::FLOW_ROW_UNTIL_OPTIONS) %>
    # @param sidebar_width [Symbol] <%= one_of(Primer::Layout::SIDEBAR_WIDTH_OPTIONS) %>
    # @param sidebar_placement [Symbol] <%= one_of(Primer::Layout::SIDEBAR_PLACEMENT_OPTIONS) %>
    # @param sidebar_flow_row_placement [Symbol] Sidebar placement when `Layout` is flowing as row. <%= one_of(Primer::Layout::SIDEBAR_FLOW_ROW_PLACEMENT_OPTIONS) %>
    # @param main_width [Symbol] <%= one_of(Primer::Layout::MAIN_WIDTH_OPTIONS) %>
    # @param with_divider [Boolean] Wether or not to add a divider between `main` and `sidebar`.
    # @param divider_flow_row_variant [Symbol] Variants for the divider when `Layout` is flowing as row. <%= one_of(Primer::Layout::DIVIDER_FLOW_ROW_VARIANT_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      density: DENSITY_DEFAULT,
      container: CONTAINER_DEFAULT,
      gutter: GUTTER_DEFAULT,
      flow_row_until: FLOW_ROW_UNTIL_DEFAULT,
      sidebar_width: SIDEBAR_WIDTH_DEFAULT,
      sidebar_placement: SIDEBAR_PLACEMENT_DEFAULT,
      sidebar_flow_row_placement: SIDEBAR_FLOW_ROW_PLACEMENT_DEFAULT,
      main_width: MAIN_WIDTH_DEFAULT,
      with_divider: false,
      divider_flow_row_variant: DIVIDER_FLOW_ROW_VARIANT_DEFAULT,
      **system_arguments
    )
      @container = container
      @with_divider = with_divider
      @sidebar_placement = fetch_or_fallback(SIDEBAR_PLACEMENT_OPTIONS, sidebar_placement, SIDEBAR_PLACEMENT_DEFAULT)
      @sidebar_flow_row_placement = fetch_or_fallback(SIDEBAR_FLOW_ROW_PLACEMENT_OPTIONS, sidebar_flow_row_placement, SIDEBAR_FLOW_ROW_PLACEMENT_DEFAULT)
      @main_width = fetch_or_fallback(MAIN_WIDTH_OPTIONS, main_width, MAIN_WIDTH_DEFAULT)

      @divider_classes = class_names(
        "Layout-divider",
        DIVIDER_FLOW_ROW_VARIANT_MAPPINGS[fetch_or_fallback(DIVIDER_FLOW_ROW_VARIANT_OPTIONS, divider_flow_row_variant, DIVIDER_FLOW_ROW_VARIANT_DEFAULT)]
      )

      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:m] = DENSITY_MAPPINGS[fetch_or_fallback(DENSITY_OPTIONS, density, DENSITY_DEFAULT)]
      @system_arguments[:classes] = class_names(
        "Layout",
        "Layout--sidebarPosition-#{@sidebar_placement}",
        "Layout--sidebarPosition-flowRow-#{@sidebar_flow_row_placement}",
        system_arguments[:classes],
        SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, sidebar_width, SIDEBAR_WIDTH_DEFAULT)],
        GUTTER_MAPPINGS[fetch_or_fallback(GUTTER_OPTIONS, gutter, GUTTER_DEFAULT)],
        FLOW_ROW_UNTIL_MAPPINGS[fetch_or_fallback(FLOW_ROW_UNTIL_OPTIONS, flow_row_until, FLOW_ROW_UNTIL_DEFAULT)],
        "Layout--divided" => with_divider
      )
    end

    def render?
      main.present? && sidebar.present?
    end

    private

    def wrapper
      if @container == :full
        yield
        return
      end

      render Primer::BaseComponent.new(tag: :div, container: @container) do
        yield
      end
    end

    # The layout's main content.
    class Main < Primer::Component
      def initialize(width:, **system_arguments)
        @width = width
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
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
  end
end
