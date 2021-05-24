# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class Layout < Primer::Component
    CONTAINER_DEFAULT = :full
    CONTAINER_OPTIONS = [:full, :xl, :lg, :md].freeze

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

    FLOW_ROW_UNTIL_DEFAULT = :sm
    FLOW_ROW_UNTIL_MAPPINGS = {
      FLOW_ROW_UNTIL_DEFAULT => "",
      :md => "Layout--flowRow-until-md",
      :lg => "Layout--flowRow-until-lg"
    }.freeze
    FLOW_ROW_UNTIL_OPTIONS = FLOW_ROW_UNTIL_MAPPINGS.keys.freeze

    MAIN_WIDTH_DEFAULT = :full
    MAIN_WIDTH_OPTIONS = [MAIN_WIDTH_DEFAULT, :sm, :md, :lg, :xl].freeze

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
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example With divider
    #
    #   <%= render(Primer::Layout.new(divider: true)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Sidebar placement
    #
    #   <%= render(Primer::Layout.new(sidebar_placement: :start)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(sidebar_placement: :end)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Sidebar widths
    #
    #   <%= render(Primer::Layout.new(sidebar_width: :default)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(sidebar_width: :narrow)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(sidebar_width: :wide)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Main widths
    #
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(width: :full) { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(width: :sm) { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(width: :md) { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(width: :lg) { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new) do |c| %>
    #     <% c.main(width: :xl) { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Gutters
    #
    #   <%= render(Primer::Layout.new(gutter: :default)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(gutter: :none)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(gutter: :condensed)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(gutter: :spacious)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Using containers
    #
    #   <%= render(Primer::Layout.new(container: :full)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(container: :xl)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(container: :lg)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(container: :md)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @example Flow row until
    #
    #   <%= render(Primer::Layout.new(flow_row_until: :sm)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(flow_row_until: :md)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #   <%= render(Primer::Layout.new(flow_row_until: :lg)) do |c| %>
    #     <% c.main { "Main" } %>
    #     <% c.sidebar { "Sidebar" } %>
    #   <% end %>
    #
    # @param container [Symbol] Container to wrap the `Layout` in. <%= one_of(Primer::Layout::CONTAINER_OPTIONS) %>
    # @param gutter [Symbol] Space between `main` and `sidebar`. <%= one_of(Primer::Layout::GUTTER_OPTIONS) %>
    # @param divider [Boolean] Wether or not to add a divider between `main` and `sidebar`.
    # @param flow_row_until [Symbol] When the `Layout` should change from a row flow into a column flow. <%= one_of(Primer::Layout::FLOW_ROW_UNTIL_OPTIONS) %>
    # @param sidebar_width [Symbol] <%= one_of(Primer::Layout::SIDEBAR_WIDTH_OPTIONS) %>
    # @param sidebar_placement [Symbol] <%= one_of(Primer::Layout::SIDEBAR_PLACEMENT_OPTIONS) %>
    # @param main_width [Symbol] <%= one_of(Primer::Layout::MAIN_WIDTH_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      container: CONTAINER_DEFAULT,
      gutter: GUTTER_DEFAULT,
      divider: false,
      flow_row_until: FLOW_ROW_UNTIL_DEFAULT,
      sidebar_width: SIDEBAR_WIDTH_DEFAULT,
      sidebar_placement: SIDEBAR_PLACEMENT_DEFAULT,
      main_width: MAIN_WIDTH_DEFAULT,
      **system_arguments
    )
      @container = container
      @divider = divider
      @sidebar_placement = fetch_or_fallback(SIDEBAR_PLACEMENT_OPTIONS, sidebar_placement, SIDEBAR_PLACEMENT_DEFAULT)
      @main_width = fetch_or_fallback(MAIN_WIDTH_OPTIONS, main_width, MAIN_WIDTH_DEFAULT)

      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "Layout",
        "Layout--sidebarPosition-#{@sidebar_placement}",
        system_arguments[:classes],
        SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, sidebar_width, SIDEBAR_WIDTH_DEFAULT)],
        GUTTER_MAPPINGS[fetch_or_fallback(GUTTER_OPTIONS, gutter, GUTTER_DEFAULT)],
        FLOW_ROW_UNTIL_MAPPINGS[fetch_or_fallback(FLOW_ROW_UNTIL_OPTIONS, flow_row_until, FLOW_ROW_UNTIL_DEFAULT)],
        "Layout--divided" => divider
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
