# frozen_string_literal: true

module Primer
  module OpenProject
    module BorderBox
      # Add a general description of component here
      # Add additional usage considerations or best practices that may aid the user to use the component correctly.
      # @accessibility Add any accessibility considerations
      class CollapsibleHeader < Primer::Component
        status :open_project

        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(title:, count: nil, description: nil, collapsed: false, box:, **system_arguments)
          @title = title
          @count = count
          @description = description
          @collapsed = collapsed
          @box = box
          @system_arguments = system_arguments

          @system_arguments[:tag] = "collapsible-header"
          @system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "CollapsibleHeader",
          )
          @system_arguments[:data] = merge_data(
            @system_arguments, {
            data: {
              action: "click:collapsible-header#toggle",
              collapsed: @collapsed
            } }
          )
        end

        private

        def before_render
          content
        end

        def render?
          raise ArgumentError, "This component must be called inside the header of a `Primer::Beta::BorderBox`" unless @box.present? && @box.is_a?(Primer::Beta::BorderBox)
          true
        end
      end
    end
  end
end
