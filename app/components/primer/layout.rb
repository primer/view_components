# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class Layout < Primer::Component
    DEFAULT_CONTAINER = :full
    CONTAINER_OPTIONS = [:full, :xl, :lg, :md].freeze

    # @example Using containers
    #
    #   <%= render(Primer::Layout.new(container: :full)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :xl)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :lg)) { "Example" } %>
    #   <%= render(Primer::Layout.new(container: :md)) { "Example" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(container: DEFAULT_CONTAINER, **system_arguments)
      @container = container
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
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
