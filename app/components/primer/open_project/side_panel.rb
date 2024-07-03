# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SidePanel < Primer::Component
      status :open_project

      # @param grid_row_arguments [Hash] Arguments to pass to +Primer::OpenProject::BorderGrid::Cell+ %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # A side panel consists of one or multiple sections
      renders_many :sections, lambda { |component = nil, grid_row_arguments: {}, **system_arguments, &block|
        if component.nil?
          @border_grid.with_row(**grid_row_arguments) do
            render(Primer::OpenProject::SidePanel::Section.new(**system_arguments)) do |section|
              evaluate_block(section, &block)
            end
          end
        elsif component.render?
          @border_grid.with_row(**grid_row_arguments) do
            render(component)
          end
        end
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:classes] = class_names(
          "SidePanel",
          @system_arguments[:classes]
        )

        @border_grid = Primer::OpenProject::BorderGrid.new(**@system_arguments)
      end

      def render?
        sections.present?
      end

      def before_render
        content
      end
    end
  end
end
