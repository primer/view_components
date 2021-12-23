# frozen_string_literal: true

module Primer
  module Beta
    # In the `SplitPageLayout`, changes in the Pane region are reflected in the `Content` region. This is also known as a "List/Detail" or "Master/Detail" pattern.
    #
    # On larger screens, the user sees both regions side by side, with the `Pane` region appearing flushed to the left.
    #
    # On smaller screens, the user only sees one of `Pane` or `Content` regions at a time.
    # Pages may decide if it's more important to show the `Pane` region or the `Content` region first by the `:primary_region` property.
    #
    # @accessibility
    #   Keyboard navigation follows the markup order. In the case of the `SplitPageLayout`, the `Pane` region is the first region, and the `Content` region is the second.
    class SplitPageLayout < Primer::Component
      status :beta

      PANE_TAG_DEFAULT = :div
      PANE_TAG_OPTIONS = [PANE_TAG_DEFAULT, :aside, :nav, :section].freeze

      PANE_WIDTH_DEFAULT = :default
      PANE_WIDTH_MAPPINGS = {
        PANE_WIDTH_DEFAULT => "",
        :narrow => "PageLayout--paneWidth-narrow",
        :wide => "PageLayout--paneWidth-wide"
      }.freeze
      PANE_WIDTH_OPTIONS = PANE_WIDTH_MAPPINGS.keys.freeze

      INNER_SPACING_DEFAULT = :normal
      INNER_SPACING_MAPPINGS = {
        normal: "PageLayout--innerSpacing-normal",
        condensed: "PageLayout--innerSpacing-condensed"
      }.freeze
      INNER_SPACING_OPTIONS = INNER_SPACING_MAPPINGS.keys.freeze

      PRIMARY_REGION_DEFAULT = :content
      PRIMARY_REGION_MAPPINGS = {
        PRIMARY_REGION_DEFAULT => "PageLayout--responsive-separateRegions-primary-content",
        :pane => "PageLayout--responsive-separateRegions-primary-pane"
      }.freeze
      PRIMARY_REGION_OPTIONS = PRIMARY_REGION_MAPPINGS.keys.freeze

      # The layout's content.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::Content::WIDTH_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::Content::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :content_region, "Primer::Beta::SplitPageLayout::Content"

      # The layout's pane.
      #
      # @param width [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::PANE_WIDTH_OPTIONS) %>
      # @param tag [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::PANE_TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :pane_region, lambda { |width: PANE_WIDTH_DEFAULT, tag: PANE_TAG_DEFAULT, **system_arguments|
        @pane_system_arguments = system_arguments
        @pane_system_arguments[:tag] = fetch_or_fallback(PANE_TAG_OPTIONS, tag, PANE_TAG_DEFAULT)
        @pane_system_arguments[:classes] = class_names(
          @pane_system_arguments[:classes],
          "PageLayout-region",
          "PageLayout-pane"
        )

        # These classes have to be set in the parent element, so we modify its system arguments.
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          PANE_WIDTH_MAPPINGS[fetch_or_fallback(PANE_WIDTH_OPTIONS, width, PANE_WIDTH_DEFAULT)]
        )

        Primer::BaseComponent.new(**@pane_system_arguments)
      }

      # @example Default
      #
      #   <%= render(Primer::Beta::SplitPageLayout.new) do |c| %>
      #     <% c.content_region(border: true) { "Content" } %>
      #     <% c.pane_region(border: true) { "Pane" } %>
      #   <% end %>
      #
      # @example Inner spacing
      #
      #   @description
      #     Sets padding to regions individually.
      #
      #     - `:condensed` keeps the margin at 16px.
      #     - `:normal` sets the margin to 16px, and to 24px on lg breakpoints and above.
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new(inner_spacing: :condensed)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(inner_spacing: :normal)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #
      # @example Responsive primary region
      #
      #   @description
      #     When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default.
      #
      #     - `:content`
      #     - `:pane`
      #
      #   @code
      #     <%= render(Primer::Beta::PageLayout.new(resposive_primary_region: :content)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::PageLayout.new(primary_region: :pane)) do |c| %>
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
      #     <%= render(Primer::Beta::SplitPageLayout.new) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :default, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::SplitPageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :narrow, border: true) { "Pane" } %>
      #     <% end %>
      #     <%= render(Primer::Beta::SplitPageLayout.new(mt: 5)) do |c| %>
      #       <% c.content_region(border: true) { "Content" } %>
      #       <% c.pane_region(width: :wide, border: true) { "Pane" } %>
      #     <% end %>
      #
      #
      # @param inner_spacing [Symbol]  Sets padding to regions individually. <%= one_of(Primer::Beta::SplitPageLayout::INNER_SPACING_OPTIONS) %>
      # @param primary_region [Symbol] When `responsive_variant` is set to `:separate_regions`, defines which region appears first on small viewports. `:content` is default. <%= one_of(Primer::Beta::SplitPageLayout::PRIMARY_REGION_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        inner_spacing: INNER_SPACING_DEFAULT,
        primary_region: PRIMARY_REGION_DEFAULT,
        **system_arguments
      )

        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          "PageLayout",
          INNER_SPACING_MAPPINGS[fetch_or_fallback(INNER_SPACING_OPTIONS, inner_spacing, INNER_SPACING_DEFAULT)],
          PRIMARY_REGION_MAPPINGS[fetch_or_fallback(PRIMARY_REGION_OPTIONS, primary_region, PRIMARY_REGION_DEFAULT)],
          "PageLayout--responsive-separateRegions",
          "PageLayout--columnGap-none",
          "PageLayout--rowGap-none",
          "PageLayout--panePos-start",
          "PageLayout--hasPaneDivider",
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

        # @param width [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::Content::WIDTH_OPTIONS) %>
        # @param tag [Symbol] <%= one_of(Primer::Beta::SplitPageLayout::Content::TAG_OPTIONS) %>
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
    end
  end
end
