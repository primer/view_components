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

    # The layout's main content.
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    renders_one :main, lambda { |**system_arguments|
      system_arguments[:tag] = :div
      system_arguments[:classes] = class_names(
        "Layout-main",
        system_arguments[:classes]
      )

      Primer::BaseComponent.new(**system_arguments)
    }

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
    # @param container [Symbol] Container to wrap the layout in. <%= one_of(Primer::Layout::CONTAINER_OPTIONS) %>
    # @param sidebar_width [Symbol] <%= one_of(Primer::Layout::SIDEBAR_WIDTH_OPTIONS) %>
    # @param gutter [Symbol] Space between `main` and `sidebar`. <%= one_of(Primer::Layout::GUTTER_OPTIONS) %>
    # @param divider [Boolean] Wether or not to add a divider between `main` and `sidebar`.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      container: CONTAINER_DEFAULT,
      sidebar_width: SIDEBAR_WIDTH_DEFAULT,
      gutter: GUTTER_DEFAULT,
      divider: false,
      **system_arguments
    )
      @container = container
      @divider = divider

      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "Layout",
        system_arguments[:classes],
        SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, sidebar_width, SIDEBAR_WIDTH_DEFAULT)],
        GUTTER_MAPPINGS[fetch_or_fallback(GUTTER_OPTIONS, gutter, GUTTER_DEFAULT)],
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
  end
end
