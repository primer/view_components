# frozen_string_literal: true

module Primer
  module Beta
    # `PageLayout` provides foundational patterns for responsive pages. `PageLayout` can be used for simple two-column pages, or it can be nested to provide flexible 3-column experiences.
    #
    #  On smaller screens, `PageLayout` uses vertically stacked rows to display content. `PageLayout` is responsible for determining the arrangement of the main regions that compose a page.
    # This means anything after the global and local headers (i.e. repo or org headers), and anything before the global footer.
    #
    #  `PageLayout` controls the page spacings, supports header and footer regions, provides different styles of panes, and handles responsive strategies.
    #
    # `PageLayout` flows as both column, when there's enough horizontal space to render both `Content` and `Pane` side-by-side (on a desktop of tablet device, per instance);
    # or it flows as a row, when `Content` and `Pane` are stacked vertically (e.g. on a mobile device).
    # `PageLayout` should always work in any screen size.
    #
    # @accessibility
    #   Keyboard navigation follows the markup order. Decide carefully how the focus order should be be by deciding whether
    #   `content_region` or `pane_region` comes first in code. This is determined by the `position` argrument to the `pane_region` slot.
    class PageLayout < Primer::Component
      status :beta

      WRAPPER_SIZING_DEFAULT = :fluid
      WRAPPER_SIZING_MAPPINGS = {
        WRAPPER_SIZING_DEFAULT => "",
        :md => "container-md",
        :lg => "container-lg",
        :xl => "container-xl"
      }.freeze
      WRAPPER_SIZING_OPTIONS = WRAPPER_SIZING_MAPPINGS.keys.freeze

      OUTER_SPACING_DEFAULT = :normal
      OUTER_SPACING_MAPPINGS = {
        OUTER_SPACING_DEFAULT => "PageLayout--outerSpacing-normal",
        :condensed => "PageLayout--outerSpacing-condensed"
      }.freeze
      OUTER_SPACING_OPTIONS = OUTER_SPACING_MAPPINGS.keys.freeze

      COLUMN_GAP_DEFAULT = :normal
      COLUMN_GAP_MAPPINGS = {
        COLUMN_GAP_DEFAULT => "PageLayout--columnGap-normal",
        :condensed => "PageLayout--columnGap-condensed"
      }.freeze
      COLUMN_GAP_OPTIONS = COLUMN_GAP_MAPPINGS.keys.freeze

      ROW_GAP_DEFAULT = :normal
      ROW_GAP_MAPPINGS = {
        ROW_GAP_DEFAULT => "PageLayout--rowGap-normal",
        :condensed => "PageLayout--rowGap-condensed"
      }.freeze
      ROW_GAP_OPTIONS = ROW_GAP_MAPPINGS.keys.freeze

      RESPONSIVE_PRIMARY_REGION_DEFAULT = :content
      RESPONSIVE_PRIMARY_REGION_MAPPINGS = {
        RESPONSIVE_PRIMARY_REGION_DEFAULT => "PageLayout--variant-separateRegions-primary-content",
        :pane => "PageLayout--variant-separateRegions-primary-pane"
      }.freeze
      RESPONSIVE_PRIMARY_REGION_OPTIONS = RESPONSIVE_PRIMARY_REGION_MAPPINGS.keys.freeze

      RESPONSIVE_VARIANT_DEFAULT = :stack_regions
      RESPONSIVE_VARIANT_MAPPINGS = {
        RESPONSIVE_VARIANT_DEFAULT => "PageLayout--variant-stackRegions",
        :separate_regions => "PageLayout--variant-separateRegions"
      }.freeze
      RESPONSIVE_VARIANT_OPTIONS = RESPONSIVE_VARIANT_MAPPINGS.keys.freeze

      HEADER_RESPONSIVE_DIVIDER_DEFAULT = :none
      HEADER_RESPONSIVE_DIVIDER_MAPPINGS = {
        HEADER_RESPONSIVE_DIVIDER_DEFAULT => "",
        :line => "PageLayout-region--hasDivider-line-before",
        :filled => "PageLayout-region--hasDivider-filled-before"
      }.freeze
      HEADER_RESPONSIVE_DIVIDER_OPTIONS = HEADER_RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze

      FOOTER_RESPONSIVE_DIVIDER_DEFAULT = :none
      FOOTER_RESPONSIVE_DIVIDER_MAPPINGS = {
        FOOTER_RESPONSIVE_DIVIDER_DEFAULT => "",
        :line => "PageLayout-region--hasDivider-line-before",
        :filled => "PageLayout-region--hasDivider-filled-before"
      }.freeze
      FOOTER_RESPONSIVE_DIVIDER_OPTIONS = FOOTER_RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze

      # The layout's content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::PageLayout::Content::WIDTH_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Beta::PageLayout::Content::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :content_region, "Primer::Beta::PageLayout::Content"

      # The layout's header.
      #
      # @param divider [Boolean] Whether to show a header divider
      # @param responsive_divider [Symbol] Whether to show a divider below the `header` region if in responsive mode. <%= one_of(Primer::Beta::PageLayout::HEADER_RESPONSIVE_DIVIDER_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :header_region, lambda { |divider: false, responsive_divider: :line, **header_system_arguments|
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "PageLayout--hasHeaderDivider" => divider
        )

        header_system_arguments[:classes] = class_names(
          header_system_arguments[:classes],
          HEADER_RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(HEADER_RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, HEADER_RESPONSIVE_DIVIDER_DEFAULT)],
          "PageLayout-header",
          "PageLayout-region"
        )

        Primer::BaseComponent.new(tag: :div, **header_system_arguments)
      }

      # The layout's footer.
      #
      # @param divider [Boolean] Whether to show a footer divider
      # @param responsive_divider [Symbol] Whether to show a divider below the `footer` region if in responsive mode. <%= one_of(Primer::Beta::PageLayout::FOOTER_RESPONSIVE_DIVIDER_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :footer_region, lambda { |divider: false, responsive_divider: FOOTER_RESPONSIVE_DIVIDER_DEFAULT, **footer_system_arguments|
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "PageLayout--hasFooterDivider" => divider
        )

        footer_system_arguments[:classes] = class_names(
          footer_system_arguments[:classes],
          FOOTER_RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(FOOTER_RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, FOOTER_RESPONSIVE_DIVIDER_DEFAULT)],
          "PageLayout-footer",
          "PageLayout-region"
        )

        Primer::BaseComponent.new(tag: :div, **footer_system_arguments)
      }

      # The layout's pane.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::PageLayout::Pane::WIDTH_OPTIONS) %>
      # @param position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::PageLayout::Pane::POSITION_OPTIONS) %>
      # @param responsive_position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::PageLayout::Pane::RESPONSIVE_POSITION_OPTIONS) %>
      # @param divider [Boolean] Whether to show a pane line divider.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane_region, lambda { |
        width: Pane::WIDTH_DEFAULT,
        position: Pane::POSITION_DEFAULT,
        responsive_position: Pane::RESPONSIVE_POSITION_DEFAULT,
        divider: false,
        **pane_system_arguments
      |
        responsive_position = position if responsive_position == Pane::RESPONSIVE_POSITION_DEFAULT
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          Pane::POSITION_MAPPINGS[fetch_or_fallback(Pane::POSITION_OPTIONS, position, Pane::POSITION_DEFAULT)],
          Pane::WIDTH_MAPPINGS[fetch_or_fallback(Pane::WIDTH_OPTIONS, width, Pane::WIDTH_DEFAULT)],
          { Pane::RESPONSIVE_POSITION_MAPPINGS[fetch_or_fallback(Pane::RESPONSIVE_POSITION_OPTIONS, responsive_position, Pane::RESPONSIVE_POSITION_DEFAULT)] => @responsive_variant == :stack_regions },
          { "PageLayout--hasPaneDivider" => divider }
        )

        pane_system_arguments[:classes] = class_names(
          pane_system_arguments[:classes],
          Pane::HAS_DIVIDER_NONE_MAPPINGS[responsive_position]
        )

        Pane.new(position: position, **pane_system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #     <% c.content_region(border: true) { "Content" } %>
      #     <% c.pane_region(border: true) { "Pane" } %>
      #   <% end %>
      #
      # @example Header and footer
      #
      #   <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #     <% c.header_region(border: true) { "Header" } %>
      #     <% c.content_region(border: true) { "Content" } %>
      #     <% c.pane_region(border: true) { "Pane" } %>
      #     <% c.footer_region(border: true) { "Footer" } %>
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
      #     <%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :fluid)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :md)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :lg)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(wrapper_sizing: :xl)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Outer spacing
      #
      #   @description
      #     Sets wrapper margins surrounding the component to distance itself from the viewport edges.
      #
      #     - `:condensed` keeps the margin at 16px.
      #     - `:normal`` sets the margin to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new(outer_spacing: :condensed)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(outer_spacing: :normal)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Column gap
      #
      #   @description
      #     Sets the gap between columns to distance them from each other.
      #
      #     - `:condensed` keeps the gap always at 16px.
      #     - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new(column_gap: :condensed)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(column_gap: :normal)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Row gap
      #
      #   @description
      #     Sets the gap below the header and above the footer.
      #
      #     - `:condensed` keeps the gap always at 16px.
      #     - `:normal` sets the gap to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new(row_gap: :condensed)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(row_gap: :normal)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
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
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :default, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :narrow, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :wide, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Pane position
      #
      #   @description
      #     Use `start` for panes that manipulate local navigation, while right-aligned `end` is useful for metadata and other auxiliary information.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(position: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new( mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(position: :end, border: true) { "Pane" } %>
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
      #     <%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(pane_responsive_position: :inherit, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(pane_responsive_position: :start, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(pane_responsive_position: :end, border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Header
      #
      #   @description
      #     You can add an optional header to the layout and have spacing and positioning taken care of for you.
      #     You can optionally add a divider to the header.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.header_region(border: true) { "Header" } %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.header_region(divider: true, border: true) { "Header" } %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Footer
      #
      #   @description
      #     You can add an optional footer to the layout and have spacing and positioning taken care of for you.
      #     You can optionally add a divider to the footer.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #       <% c.footer_region(border: true) { "Header" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #       <% c.footer_region(divider: true, border: true) { "Header" } %>
      #     <% end %>
      #
      # @param wrapper_sizing [Symbol] Define the maximum width of the component. `:fluid` sets it to full-width. Other values center Layout horizontally. <%= one_of(Primer::Beta::PageLayout::WRAPPER_SIZING_OPTIONS) %>
      # @param outer_spacing [Symbol] Sets wrapper margins surrounding the component to distance itself from the viewport edges. <%= one_of(Primer::Beta::PageLayout::OUTER_SPACING_OPTIONS) %>
      # @param column_gap [Symbol] Sets gap between columns. <%= one_of(Primer::Beta::PageLayout::COLUMN_GAP_OPTIONS) %>
      # @param row_gap [Symbol] Sets the gap below the header and above the footer. <%= one_of(Primer::Beta::PageLayout::ROW_GAP_OPTIONS) %>
      # @param responsive_variant [Symbol] Defines how the layout component adapts to smaller viewports. `:stack_regions` presents the content in a vertical flow, with pane and content vertically arranged. `:separate_regions` presents pane and content as different pages on smaller viewports.
      # @param responsive_primary_region [Symbol] When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        wrapper_sizing: WRAPPER_SIZING_DEFAULT,
        outer_spacing: OUTER_SPACING_DEFAULT,
        column_gap: COLUMN_GAP_DEFAULT,
        row_gap: ROW_GAP_DEFAULT,
        responsive_variant: RESPONSIVE_VARIANT_DEFAULT,
        responsive_primary_region: RESPONSIVE_PRIMARY_REGION_DEFAULT,
        **system_arguments
      )

        @wrapper_sizing_class = WRAPPER_SIZING_MAPPINGS[fetch_or_fallback(WRAPPER_SIZING_OPTIONS, wrapper_sizing, WRAPPER_SIZING_DEFAULT)]
        @responsive_variant = responsive_variant
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "PageLayout",
          OUTER_SPACING_MAPPINGS[fetch_or_fallback(OUTER_SPACING_OPTIONS, outer_spacing, OUTER_SPACING_DEFAULT)],
          COLUMN_GAP_MAPPINGS[fetch_or_fallback(COLUMN_GAP_OPTIONS, column_gap, COLUMN_GAP_DEFAULT)],
          ROW_GAP_MAPPINGS[fetch_or_fallback(ROW_GAP_OPTIONS, row_gap, ROW_GAP_DEFAULT)],
          RESPONSIVE_VARIANT_MAPPINGS[fetch_or_fallback(RESPONSIVE_VARIANT_OPTIONS, @responsive_variant, RESPONSIVE_VARIANT_DEFAULT)],
          { RESPONSIVE_PRIMARY_REGION_MAPPINGS[fetch_or_fallback(RESPONSIVE_PRIMARY_REGION_OPTIONS, responsive_primary_region, RESPONSIVE_PRIMARY_REGION_DEFAULT)] => @responsive_variant == :separate_regions },
          system_arguments[:classes]
        )
      end

      def render?
        content_region.present? && pane_region.present?
      end

      # The layout's content.
      class Content < Primer::Component
        status :beta

        WIDTH_DEFAULT = :fluid
        WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

        # @param width [Symbol] <%= one_of(Primer::Beta::PageLayout::Content::WIDTH_OPTIONS) %>
        # @param tag [Symbol] <%= one_of(Primer::Beta::PageLayout::Content::TAG_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: TAG_DEFAULT, width: WIDTH_DEFAULT, **system_arguments)
          @width = fetch_or_fallback(WIDTH_OPTIONS, width, WIDTH_DEFAULT)

          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "PageLayout-region",
            "PageLayout-content",
            system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            if @width == :fluid
              content
            else
              render(Primer::BaseComponent.new(tag: :div, classes: "PageLayout-content-centered-#{@width}")) do
                render(Primer::BaseComponent.new(tag: :div, container: @width)) do
                  content
                end
              end
            end
          end
        end
      end

      # The layout's pane content. This is a secondary, smaller region that is paired with the `Content` region.
      class Pane < Primer::Component
        status :beta

        WIDTH_DEFAULT = :default
        WIDTH_MAPPINGS = {
          WIDTH_DEFAULT => "",
          :narrow => "PageLayout--paneWidth-narrow",
          :wide => "PageLayout--paneWidth-wide"
        }.freeze
        WIDTH_OPTIONS = WIDTH_MAPPINGS.keys.freeze

        RESPONSIVE_POSITION_DEFAULT = :inherit
        RESPONSIVE_POSITION_MAPPINGS = {
          RESPONSIVE_POSITION_DEFAULT => "",
          :start => "PageLayout--variant-stackRegions-panePos-start",
          :end => "PageLayout--variant-stackRegions-panePos-end"
        }.freeze
        RESPONSIVE_POSITION_OPTIONS = RESPONSIVE_POSITION_MAPPINGS.keys.freeze

        DIVIDER_DEFAULT = :start
        DIVIDER_MAPPINGS = {
          DIVIDER_DEFAULT => "PageLayout--panePos-start",
          :end => "PageLayout--panePos-start"
        }.freeze
        DIVIDER_OPTIONS = DIVIDER_MAPPINGS.keys.freeze

        POSITION_DEFAULT = :start
        POSITION_MAPPINGS = {
          POSITION_DEFAULT => "PageLayout--panePos-start",
          :end => "PageLayout--panePos-end"
        }.freeze
        POSITION_OPTIONS = POSITION_MAPPINGS.keys.freeze

        RESPONSIVE_DIVIDER_DEFAULT = :none
        RESPONSIVE_DIVIDER_MAPPINGS = {
          RESPONSIVE_DIVIDER_DEFAULT => "",
          :line => "PageLayout--divider-after",
          :filled => "PageLayout--divider-after-filled"
        }.freeze
        RESPONSIVE_DIVIDER_OPTIONS = RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze

        HAS_DIVIDER_NONE_MAPPINGS = {
          start: "PageLayout-region--hasDivider-none-before",
          end: "PageLayout-region--hasDivider-none-after"
        }.freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :aside, :nav, :section].freeze

        # @param tag [Symbol] <%= one_of(Primer::Beta::PageLayout::Pane::TAG_OPTIONS) %>
        def initialize(responsive_divider: RESPONSIVE_DIVIDER_DEFAULT, position: POSITION_DEFAULT, tag: TAG_DEFAULT, **system_arguments)
          @system_arguments = system_arguments
          @position = position

          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "PageLayout-region",
            "PageLayout-pane",
            RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, RESPONSIVE_DIVIDER_DEFAULT)],
            @system_arguments[:classes]
          )
        end

        def render_first?
          @position == :start
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { content }
        end
      end
    end
  end
end
