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
    class SplitLayout < Primer::Component
      status :beta

      PANE_TAG_DEFAULT = :div
      PANE_TAG_OPTIONS = [PANE_TAG_DEFAULT, :aside, :nav, :section].freeze

      PANE_WIDTH_DEFAULT = :default
      PANE_WIDTH_MAPPINGS = {
        PANE_WIDTH_DEFAULT => "",
        :narrow => "LayoutBeta--pane-width-narrow",
        :wide => "LayoutBeta--pane-width-wide"
      }.freeze
      PANE_WIDTH_OPTIONS = PANE_WIDTH_MAPPINGS.keys.freeze

      INNER_SPACING_DEFAULT = :normal
      INNER_SPACING_MAPPINGS = {
        normal: "LayoutBeta--inner-spacing-normal",
        condensed: "LayoutBeta--inner-spacing-condensed"
      }.freeze
      INNER_SPACING_OPTIONS = INNER_SPACING_MAPPINGS.keys.freeze

      RESPONSIVE_PRIMARY_REGION_DEFAULT = :content
      RESPONSIVE_PRIMARY_REGION_MAPPINGS = {
        RESPONSIVE_PRIMARY_REGION_DEFAULT => "LayoutBeta--primary-content",
        :pane => "LayoutBeta--primary-pane"
      }.freeze
      RESPONSIVE_PRIMARY_REGION_OPTIONS = RESPONSIVE_PRIMARY_REGION_MAPPINGS.keys.freeze
      # The layout's main content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::SplitLayout::Main::WIDTH_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Beta::SplitLayout::Main::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :main, "Primer::Beta::SplitLayout::Main"

      # The layout's sidebar.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::SplitLayout::PANE_WIDTH_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Beta::SplitLayout::PANE_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane, lambda { |
        width: PANE_WIDTH_DEFAULT,
        tag: PANE_TAG_DEFAULT,
        **system_arguments
      |

        @pane_system_arguments = system_arguments
        @pane_system_arguments[:tag] = fetch_or_fallback(PANE_TAG_OPTIONS, tag, PANE_TAG_DEFAULT)
        @pane_system_arguments[:classes] = class_names(
          @pane_system_arguments[:classes],
          "LayoutBeta-pane",
        )

        # These classes have to be set in the parent `Layout` element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "LayoutBeta--pane-position-start",
          PANE_WIDTH_MAPPINGS[fetch_or_fallback(PANE_WIDTH_OPTIONS, width, PANE_WIDTH_DEFAULT)],
          "LayoutBeta--pane-divider"
        )

        Primer::BaseComponent.new(**@pane_system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Beta::SplitLayout.new) do |c| %>
      #     <% c.main(border: true) { "Main" } %>
      #     <% c.pane(border: true) { "Pane" } %>
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
      #     <%= render(Primer::Beta::SplitLayout.new) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :default, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::SplitLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :narrow, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::SplitLayout.new(mt: 5)) do |c| %>
      #       <% c.main(border: true) { "Main" } %>
      #       <% c.pane(width: :wide, border: true) { "Pane" } %>
      #     <% end %>
      #
      #
      # @param inner_spacing [Symbol]  Sets padding to regions individually. <%= one_of(Primer::Beta::SplitLayout::INNER_SPACING_OPTIONS) %>
      # @param responsive_primary_region [Symbol] When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. <%= one_of(Primer::Beta::SplitLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        inner_spacing: INNER_SPACING_DEFAULT,
        responsive_primary_region: RESPONSIVE_PRIMARY_REGION_DEFAULT,
        **system_arguments
      )

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "LayoutBeta",
          INNER_SPACING_MAPPINGS[fetch_or_fallback(INNER_SPACING_OPTIONS, inner_spacing, INNER_SPACING_DEFAULT)],
          RESPONSIVE_PRIMARY_REGION_MAPPINGS[fetch_or_fallback(RESPONSIVE_PRIMARY_REGION_OPTIONS, responsive_primary_region, RESPONSIVE_PRIMARY_REGION_DEFAULT)],
          "LayoutBeta--variant-separateRegions",
          "LayoutBeta--column-gap-none",
          "LayoutBeta--row-gap-none",
          "LayoutBeta--pane-position-start",
          "LayoutBeta--pane-divider",
          "LayoutBeta--variant-md-multiColumns",
          system_arguments[:classes]
        )
      end

      def render?
        main.present? && pane.present?
      end

      # The layout's main content.
      class Main < Primer::Component
        WIDTH_DEFAULT = :fluid
        WIDTH_OPTIONS = [WIDTH_DEFAULT, :md, :lg, :xl].freeze

        TAG_DEFAULT = :div
        TAG_OPTIONS = [TAG_DEFAULT, :main].freeze

        # @param width [Symbol] <%= one_of(Primer::Beta::SplitLayout::Main::WIDTH_OPTIONS) %>
        # @param tag [Symbol] <%= one_of(Primer::Beta::SplitLayout::Main::TAG_OPTIONS) %>
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
    end
  end
end
