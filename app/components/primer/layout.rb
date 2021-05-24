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
    }
    SIDEBAR_WIDTH_OPTIONS = SIDEBAR_WIDTH_MAPPINGS.keys.freeze

    # @example Sidebar widths
    #
    #   <%= render(Primer::Layout.new(sidebar_width: :default)) { "Example" } %>
    #   <%= render(Primer::Layout.new(sidebar_width: :narrow)) { "Example" } %>
    #   <%= render(Primer::Layout.new(sidebar_width: :wide)) { "Example" } %>
    #
    # @example Using containers
    #
    #   <%= render(Primer::Layout.new(container: :full)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :xl)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :lg)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :md)) { "Example" } %>
    #
    # @param container [Symbol] Container to wrap the layout in. <%= one_of(Primer::Layout::CONTAINER_OPTIONS) %>
    # @param sidebar_width [Symbol] <%= one_of(Primer::Layout::SIDEBAR_WIDTH_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(
      container: CONTAINER_DEFAULT,
      sidebar_width: SIDEBAR_WIDTH_DEFAULT,
      **system_arguments
    )
      @container = container
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        "Layout",
        system_arguments[:classes],
        SIDEBAR_WIDTH_MAPPINGS[fetch_or_fallback(SIDEBAR_WIDTH_OPTIONS, sidebar_width, SIDEBAR_WIDTH_DEFAULT)]
      )
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
