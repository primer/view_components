# frozen_string_literal: true

module Primer
  module OpenProject
    class BorderGrid
      # A single cell inside the BorderGrid
      # A cell can contain for example an action list or a status badge
      class Cell < Primer::Component
        status :open_project

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(**system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = "div"

          @system_arguments[:classes] =
            class_names(
              @system_arguments[:classes],
              "BorderGrid-cell"
            )
        end
      end
    end
  end
end
