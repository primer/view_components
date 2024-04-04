# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class ZenModeButton < Primer::Component
      status :open_project

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "zen-mode-button"
        @system_arguments[:classes] =
        class_names(
          @system_arguments[:classes],
          "ZenModeButton"
        )
      end
    end
  end
end
