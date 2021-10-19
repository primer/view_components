# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class BorderBoxHeader < Primer::Component
      # @example Example goes here
      #
      #   <%= render(Primer::BorderBoxHeader.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>

      # Optional Title.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      # @accessibility
      # When using header.title, the recommended tag is a heading tag, such as h1, h2, h3, etc.
      renders_one :title, lamba { |**system_arguments|
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          "Box-title",
          system_arguments[:classes]
        )

        Primer::BaseComponent.new(**system_arguments)
      }

      def initialize(**system_arguments)
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          "Box-header",
          system_arguments[:classes]
        )
        @system_arguments = system_arguments
      end
    end
  end
end
