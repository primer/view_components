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
    class SplitLayout < BaseLayout
      status :beta

      # The layout's main content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::Main::WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :main, BaseLayout::Main

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::PANE_WIDTH_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane, lambda { |
        width: BaseLayout::PANE_WIDTH_DEFAULT,
        **system_arguments
      |

        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          Pane::POSITION_MAPPINGS[:start],
          BaseLayout::PANE_WIDTH_MAPPINGS[fetch_or_fallback(BaseLayout::PANE_WIDTH_OPTIONS, width, BaseLayout::PANE_WIDTH_DEFAULT)],
          "LayoutBeta--pane-divider"
        )

        Primer::Beta::BaseLayout::Pane.new(position: :start, **system_arguments)
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
      # @param inner_spacing [Symbol]  Sets padding to regions individually. <%= one_of(Primer::Beta::BaseLayout::INNER_SPACING_OPTIONS) %>
      # @param responsive_primary_region [Symbol] When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        inner_spacing: BaseLayout::INNER_SPACING_DEFAULT,
        responsive_primary_region: BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT,
        **system_arguments
      )

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "LayoutBeta",
          BaseLayout::INNER_SPACING_MAPPINGS[fetch_or_fallback(BaseLayout::INNER_SPACING_OPTIONS, inner_spacing, BaseLayout::INNER_SPACING_DEFAULT)],
          BaseLayout::RESPONSIVE_VARIANT_MAPPINGS[fetch_or_fallback(BaseLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, responsive_primary_region, BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)],
          BaseLayout::RESPONSIVE_VARIANT_MAPPINGS[:separate_regions],
          BaseLayout::COLUMN_GAP_MAPPINGS[:none],
          BaseLayout::ROW_GAP_MAPPINGS[:none],
          system_arguments[:classes]
        )
      end

      def render?
        main.present? && pane.present?
      end
    end
  end
end
