# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class TaskList < Primer::Component
    # @example Example goes here
    #
    #   <%= render(Primer::TaskList.new) { "Example" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end
  end
end
