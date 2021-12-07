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
    class BaseLayout < Primer::Component
      status :beta

      WRAPPER_SIZING_DEFAULT = :fluid
      WRAPPER_SIZING_MAPPINGS = {
        WRAPPER_SIZING_DEFAULT => "",
        :md => "container-md",
        :lg => "container-lg",
        :xl => "container-xl",
      }.freeze
      WRAPPER_SIZING_OPTIONS = WRAPPER_SIZING_MAPPINGS.keys.freeze

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

      RESPONSIVE_VARIANT_DEFAULT = :stack_regions
      RESPONSIVE_VARIANT_MAPPINGS = {
        RESPONSIVE_VARIANT_DEFAULT => "LayoutBeta--variant-stackRegions",
        :separate_regions => "LayoutBeta--variant-separateRegions"
      }.freeze
      RESPONSIVE_VARIANT_OPTIONS = RESPONSIVE_VARIANT_MAPPINGS.keys.freeze

      RESPONSIVE_PRIMARY_REGION_DEFAULT = :content
      RESPONSIVE_PRIMARY_REGION_MAPPINGS = {
        RESPONSIVE_PRIMARY_REGION_DEFAULT => "LayoutBeta--primary-content",
        :pane => "LayoutBeta--primary-pane"
      }.freeze
      RESPONSIVE_PRIMARY_REGION_OPTIONS = RESPONSIVE_PRIMARY_REGION_MAPPINGS.keys.freeze

      MULTI_COLUMNS_VARIANT_AT_DEFAULT = :md
      MULTI_COLUMNS_VARIANT_AT_MAPPINGS = {
        MULTI_COLUMNS_VARIANT_AT_DEFAULT => "LayoutBeta--variant-stackRegions",
        :lg => "LayoutBeta--variant-separateRegions",
      }.freeze
      MULTI_COLUMNS_VARIANT_AT_OPTIONS = MULTI_COLUMNS_VARIANT_AT_MAPPINGS.keys.freeze

      PANE_WIDTH_DEFAULT = :default
      PANE_WIDTH_MAPPINGS = {
        PANE_WIDTH_DEFAULT => "",
        :narrow => "LayoutBeta--pane-width-narrow",
        :wide => "LayoutBeta--pane-width-wide"
      }.freeze
      PANE_WIDTH_OPTIONS = PANE_WIDTH_MAPPINGS.keys.freeze

      PANE_RESPONSIVE_POSITION_DEFAULT = :inherit
      PANE_RESPONSIVE_POSITION_MAPPINGS = {
        PANE_RESPONSIVE_POSITION_DEFAULT => "",
        :start => "LayoutBeta--stackRegions-pane-position-start",
        :end => "LayoutBeta--stackRegions-pane-position-end"
      }.freeze
      PANE_RESPONSIVE_POSITION_OPTIONS = PANE_RESPONSIVE_POSITION_MAPPINGS.keys.freeze

      PANE_DIVIDER_DEFAULT = :start
      PANE_DIVIDER_MAPPINGS = {
        PANE_DIVIDER_DEFAULT => "LayoutBeta--pane-position-start",
        :end => "LayoutBeta--pane-position-start"
      }.freeze
      PANE_DIVIDER_OPTIONS = PANE_DIVIDER_MAPPINGS.keys.freeze

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::PANE_WIDTH_OPTIONS) %>
      # @param position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::BaseLayout::Pane::POSITION_OPTIONS) %>
      # @param responsive_position [Symbol] Pane placement when `Layout` is in column modes. <%= one_of(Primer::Beta::BaseLayout::PANE_RESPONSIVE_POSITION_OPTIONS) %>
      # @param divider [Boolean] Whether to show a pane line divider.
      # @param sticky [Boolean] Whether to make the pane sticky. Don’t use it in the presence of footer regions.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      PANE_CONFIGURATION = lambda { |
        width: PANE_WIDTH_DEFAULT,
        position: Pane::POSITION_DEFAULT,
        responsive_position: PANE_RESPONSIVE_POSITION_DEFAULT,
        sticky: false,
        divider: false,
        responsive_divider: PANE_RESPONSIVE_DIVIDER_DEFAULT,
        **system_arguments
      |

        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          Pane::POSITION_MAPPINGS[fetch_or_fallback(Pane::POSITION_OPTIONS, position, Pane::POSITION_DEFAULT)],
          PANE_RESPONSIVE_POSITION_MAPPINGS[fetch_or_fallback(PANE_RESPONSIVE_POSITION_OPTIONS, responsive_position, PANE_RESPONSIVE_POSITION_DEFAULT)],
          PANE_RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(PANE_RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, PANE_RESPONSIVE_DIVIDER_DEFAULT)],
          PANE_WIDTH_MAPPINGS[fetch_or_fallback(PANE_WIDTH_OPTIONS, width, PANE_WIDTH_DEFAULT)],
          { "LayoutBeta--pane-divider" => divider },
          { "LayoutBeta--pane-is-sticky" => sticky }
        )

        Primer::Beta::BaseLayout::Pane.new(position: position, **system_arguments)
      }

      # The layout's header.
      #
      # @param divider [Boolean] Whether to show a header divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `header` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      HEADER_CONFIGURATION = lambda { |divider: false, **header_system_arguments|
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "LayoutBeta--header-divider" => divider
        )

        header_system_arguments[:classes] = class_names(
          header_system_arguments[:classes],
          "LayoutBeta-header"
        )

        Primer::Beta::BaseLayout::Bookend.new(divider: divider, **header_system_arguments)
      }

      # The layout's footer.
      #
      # @param divider [Boolean] Whether to show a footer divider
      # @param responsive_divider [Boolean] Whether to show a divider below the `footer` region if in responsive mode
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      FOOTER_CONFIGURATION = lambda { |divider: false, **footer_system_arguments|
        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "LayoutBeta--has-footer",
          "LayoutBeta--footer-divider" => divider
        )

        footer_system_arguments[:classes] = class_names(
          footer_system_arguments[:classes],
          "LayoutBeta-footer"
        )

        Primer::Beta::BaseLayout::Bookend.new(divider: divider, **footer_system_arguments)
      }

      # The layout's main content.
      class Main < Primer::Component
        WIDTH_DEFAULT = :fluid
        WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

        # @param width [Symbol] <%= one_of(Primer::Beta::BaseLayout::Main::WIDTH_OPTIONS) %>
        # @param tag [Symbol] <%= one_of(Primer::Beta::BaseLayout::Main::TAG_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(tag: TAG_DEFAULT, width: WIDTH_DEFAULT, **system_arguments)
          @width = fetch_or_fallback(WIDTH_OPTIONS, width, WIDTH_DEFAULT)

          @system_arguments = system_arguments
          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "LayoutBeta-region",
            "LayoutBeta-content",
            system_arguments[:classes]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) do
            if @width == :fluid
              content
            else
              render(Primer::BaseComponent.new(tag: :div, classes: "LayoutBeta-content-centered-#{@width}")) do
                render(Primer::BaseComponent.new(tag: :div, container: @width)) do
                  content
                end
              end
            end
          end
        end
      end

      # The layout's header or footer content. This component is used by the `header` and `footer` slots and configured via those slots.
      class Bookend < Primer::Component
        RESPONSIVE_DIVIDER_DEFAULT = :none
        RESPONSIVE_DIVIDER_MAPPINGS = {
          RESPONSIVE_DIVIDER_DEFAULT => "",
          :line => "LayoutBeta--divider-after",
          :filled => "LayoutBeta--divider-after-filled"
        }.freeze
        RESPONSIVE_DIVIDER_OPTIONS = RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze

        # @param responsive_divider [Symbol] <%= one_of(Primer::Beta::BaseLayout::Bookend::RESPONSIVE_DIVIDER_OPTIONS) %>
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(responsive_divider: RESPONSIVE_DIVIDER_DEFAULT, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:classes] = class_names(
            @system_arguments[:classes],
            RESPONSIVE_DIVIDER_MAPPINGS[fetch_or_fallback(RESPONSIVE_DIVIDER_OPTIONS, responsive_divider, RESPONSIVE_DIVIDER_DEFAULT)]
          )
        end

        def call
          render(Primer::BaseComponent.new(tag: :div, **@system_arguments)) { content }
        end
      end

      # The layout's pane content. This is a secondary, smaller region that is paired with the `Main` region.
      class Pane < Primer::Component
        POSITION_DEFAULT = :start
        POSITION_MAPPINGS = {
          POSITION_DEFAULT => "LayoutBeta--pane-position-start",
          :end => "LayoutBeta--pane-position-end"
        }.freeze
        POSITION_OPTIONS = POSITION_MAPPINGS.keys.freeze

        RESPONSIVE_DIVIDER_DEFAULT = :none
        RESPONSIVE_DIVIDER_MAPPINGS = {
          RESPONSIVE_DIVIDER_DEFAULT => "",
          :line => "LayoutBeta--divider-after",
          :filled => "LayoutBeta--divider-after-filled"
        }.freeze
        RESPONSIVE_DIVIDER_OPTIONS = RESPONSIVE_DIVIDER_MAPPINGS.keys.freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :aside, :nav, :section].freeze

        # @param tag [Symbol] <%= one_of(Primer::Beta::BaseLayout::Pane::TAG_OPTIONS) %>
        def initialize(responsive_divider: RESPONSIVE_DIVIDER_DEFAULT, position: POSITION_DEFAULT, tag: TAG_DEFAULT, **system_arguments)
          @system_arguments = system_arguments
          @position = position

          @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_DEFAULT)
          @system_arguments[:classes] = class_names(
            "LayoutBeta-region",
            "LayoutBeta-pane",
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
