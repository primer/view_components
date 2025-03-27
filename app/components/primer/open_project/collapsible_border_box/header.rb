# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class CollapsibleBorderBox::Header < Primer::Component
      status :open_project

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(title:, count: nil, **system_arguments)
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~123"
        @title = title
        @count = count
        @system_arguments = system_arguments
        @system_arguments[:tag] = "div"
      end

      private

      def before_render
        content
      end
    end
  end
end
