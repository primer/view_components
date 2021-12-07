# frozen_string_literal: true

module Primer
  module Beta
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class PageLayout < Primer::Component
      # @example Example goes here
      #
      #   <%= render(Primer::PageLayout.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end
    end
  end
end
