# frozen_string_literal: true

module Primer
  module OpenProject
    # A set of blocks that are shown below each other with separator lines in between
    class BorderGrid < Primer::Component
      status :open_project

      # Use to render a block inside the grid
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_many :rows, lambda { |**system_arguments|
        Primer::OpenProject::BorderGrid::Cell.new(**system_arguments)
      }

      # @param spacious [Boolean] Whether to add margin to the bottom of the component.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(spacious: false, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "div"
        @spacious = spacious

        @system_arguments[:classes] =
          class_names(
            @system_arguments[:classes],
            "BorderGrid",
            "BorderGrid--spacious" => @spacious
          )
      end

      def render?
        rows.any?
      end
    end
  end
end
