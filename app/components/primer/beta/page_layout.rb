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
    # `Layout` also provides `Header` and `Footer` slots, which can be used to provide a consistent header and footer across all pages.
    #
    # @accessibility
    #   Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
    #   `main` or `pane` comes first in code. The code order won’t affect the visual position.
    class PageLayout < Primer::Component
      status :beta

      # The layout's main content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::Main::WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :main, BaseLayout::Main

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::PANE_WIDTH_OPTIONS) %>
      # @param position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::BaseLayout::Pane::POSITION_OPTIONS) %>
      # @param responsive_position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::BaseLayout::PANE_RESPONSIVE_POSITION_OPTIONS) %>
      # @param divider [Boolean] Whether to show a pane line divider.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane, lambda { |
        width: BaseLayout::PANE_WIDTH_DEFAULT,
        position: BaseLayout::Pane::POSITION_DEFAULT,
        responsive_position: BaseLayout::PANE_RESPONSIVE_POSITION_DEFAULT,
        divider: false,
        **system_arguments
      |

        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          BaseLayout::Pane::POSITION_MAPPINGS[fetch_or_fallback(BaseLayout::Pane::POSITION_OPTIONS, position, BaseLayout::Pane::POSITION_DEFAULT)],
          BaseLayout::PANE_RESPONSIVE_POSITION_MAPPINGS[fetch_or_fallback(BaseLayout::PANE_RESPONSIVE_POSITION_OPTIONS, responsive_position, BaseLayout::PANE_RESPONSIVE_POSITION_DEFAULT)],
          BaseLayout::PANE_WIDTH_MAPPINGS[fetch_or_fallback(BaseLayout::PANE_WIDTH_OPTIONS, width, BaseLayout::PANE_WIDTH_DEFAULT)],
          { "LayoutBeta--pane-divider" => divider },
        )

        Primer::Beta::BaseLayout::Pane.new(position: position, **system_arguments)
      }

      # The layout's header.
      #
      # @param divider [Boolean] Whether to show a header divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `header` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :header, BaseLayout::HEADER_CONFIGURATION

      # The layout's footer.
      #
      # @param divider [Boolean] Whether to show a footer divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `footer` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :footer, BaseLayout::FOOTER_CONFIGURATION

      # @example Default
      #
      #   <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #     <% c.main(border: true) { "Main" } %>
      #     <% c.pane(border: true) { "Pane" } %>
      #   <% end %>
      #
      # @example Header and footer
      #
      #   <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #     <% c.header(border: true) { "Header" } %>
      #     <% c.main(border: true) { "Main" } %>
      #     <% c.pane(border: true) { "Pane" } %>
      #     <% c.footer(border: true) { "Footer" } %>
      #   <% end %>
      #
      # @example Wrapper sizing
      #
      #   @description
      #     When `:fluid` the layout will be set to full width. When the other sizing options are used the layout will be centered with corresponding widths.
      #
      #     - `:fluid`: full width
      #     - `:md`: max-width: 768px
      #     - `:lg`: max-width: 1012px
      #     - `:xl`: max-width: 1280px
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new(wrapper_sizing: :fluid)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(wrapper_sizing: :md)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(wrapper_sizing: :lg)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(wrapper_sizing: :xl)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Outer spacing
      #
      #   @description
      #     Sets wrapper margins surrounding the component to distance itself from the viewport edges.
      #
      #     - `:none`` sets the margin to 0.
      #     - `:condensed` keeps the margin at 16px.
      #     - `:normal`` sets the margin to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new(outer_spacing: :none)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(outer_spacing: :condensed)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(outer_spacing: :normal)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Column gap
      #
      #   @description
      #     Sets the gap between columns to distance them from each other.
      #
      #     - `:none` sets the gap to 0.
      #     - `:condensed` keeps the gap always at 16px.
      #     - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new(column_gap: :none)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(column_gap: :condensed)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(column_gap: :normal)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Row gap
      #
      #   @description
      #     Sets the gap below the header and above the footer.
      #
      #     - `:none` sets the gap to 0.
      #     - `:condensed` keeps the gap always at 16px.
      #     - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new(row_gap: :none)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(row_gap: :condensed)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(row_gap: :normal)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane widths
      #
      #   @description
      #     Sets the pane width. The width is predetermined according to the breakpoint instead of it being percentage-based.
      #
      #     - `default`:
      #     - `narrow`:
      #     - `wide`:
      #
      #     When flowing as a row, `Pane` takes the full width.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :default, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :narrow, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :wide, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane position
      #
      #   @description
      #     Use `start` for sidebars that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(position: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new( mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(position: :end, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane resposive position
      #
      #   @description
      #     Defines the position of the pane in the responsive layout.
      #
      #     - `:start` puts the pane above content
      #     - `:end` puts it below content.
      #     - `:inherit` uses the same value from `pane_position`
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(pane_responsive_position: :inherit, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(pane_responsive_position: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(pane_responsive_position: :end, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Header
      #
      #   @description
      #     You can add an optional header to the layout and have spacing and positioning taken care of for you.
      #     You can optionally add a divider to the header.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.header(border: true) { "Header" } %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.header(divider: true, border: true) { "Header" } %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Footer
      #
      #   @description
      #     You can add an optional footer to the layout and have spacing and positioning taken care of for you.
      #     You can optionally add a divider to the footer.
      #
      #   @code
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #       <% c.footer(border: true) { "Header" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::BaseLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(border: true) { "Pane" } %>
      #       <% c.footer(divider: true, border: true) { "Header" } %>
      #     <% end %>
      #
      # @param wrapper_sizing [Symbol] The size of the container wrapping `Layout`. <%= one_of(Primer::Beta::BaseLayout::WRAPPER_SIZING_OPTIONS) %>
      # @param outer_spacing [Symbol] Sets wrapper margins surrounding the component to distance itself from the viewport edges. <%= one_of(Primer::Beta::BaseLayout::OUTER_SPACING_OPTIONS) %>
      # @param column_gap [Symbol] Sets gap between columns. <%= one_of(Primer::Beta::BaseLayout::COLUMN_GAP_OPTIONS) %>
      # @param row_gap [Symbol] Sets the gap below the header and above the footer. <%= one_of(Primer::Beta::BaseLayout::ROW_GAP_OPTIONS) %>
      # @param responsive_variant [Symbol] Defines how the layout component adapts to smaller viewports. `:stack_regions` presents the content in a vertical flow, with pane and content vertically arranged. `:separate_regions` presents pane and content as different pages on smaller viewports.
      # @param responsive_primary_region [Symbol] When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        wrapper_sizing: BaseLayout::WRAPPER_SIZING_DEFAULT,
        outer_spacing: BaseLayout::OUTER_SPACING_DEFAULT,
        column_gap: BaseLayout::COLUMN_GAP_DEFAULT,
        row_gap: BaseLayout::ROW_GAP_DEFAULT,
        responsive_variant: BaseLayout::RESPONSIVE_VARIANT_DEFAULT,
        responsive_primary_region: BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT,
        **system_arguments
      )
        @wrapper_sizing_class = BaseLayout::WRAPPER_SIZING_MAPPINGS[fetch_or_fallback(BaseLayout::WRAPPER_SIZING_OPTIONS, wrapper_sizing, BaseLayout::WRAPPER_SIZING_DEFAULT)]

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "LayoutBeta",
          BaseLayout::OUTER_SPACING_MAPPINGS[fetch_or_fallback(BaseLayout::OUTER_SPACING_OPTIONS, outer_spacing, BaseLayout::OUTER_SPACING_DEFAULT)],
          BaseLayout::COLUMN_GAP_MAPPINGS[fetch_or_fallback(BaseLayout::COLUMN_GAP_OPTIONS, column_gap, BaseLayout::COLUMN_GAP_DEFAULT)],
          BaseLayout::ROW_GAP_MAPPINGS[fetch_or_fallback(BaseLayout::ROW_GAP_OPTIONS, row_gap, BaseLayout::ROW_GAP_DEFAULT)],
          BaseLayout::RESPONSIVE_PRIMARY_REGION_MAPPINGS[fetch_or_fallback(BaseLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, responsive_primary_region, BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)],
          BaseLayout::RESPONSIVE_VARIANT_MAPPINGS[fetch_or_fallback(BaseLayout::RESPONSIVE_VARIANT_OPTIONS, responsive_variant, BaseLayout::RESPONSIVE_VARIANT_DEFAULT)],
          system_arguments[:classes]
        )
      end

      def render?
        main.present? && pane.present?
      end
    end
  end
end
