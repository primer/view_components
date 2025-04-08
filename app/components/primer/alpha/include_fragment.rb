# frozen_string_literal: true

module Primer
  module Alpha
    # Use `IncludeFragment` to load HTML elements from the server.
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class IncludeFragment < Primer::Component
      status :alpha

      # @param src [String] The URL  from which to retrieve an HTML element fragment.
      # @param loading [Symbol] <%= one_of([:lazy, :eager]) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(src: nil, loading: :eager, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "include-fragment"
        @system_arguments[:loading] = loading
        @system_arguments[:src] = src
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
