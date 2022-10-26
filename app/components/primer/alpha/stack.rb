# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class Stack < Primer::Component
      status :alpha

      renders_many :items, lambda { |**system_arguments|
        system_arguments[:tag] = :div
        system_arguments[:classes] = class_names(
          "Stack-item"
        )
        Primer::BaseComponent.new(**system_arguments)
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::Stack.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :div
        @system_arguments[:classes] = class_names(
          "Stack",
          "Stack--dir-block-whenRegular": true,
          "Stack--dir-block-whenNarrow": true
        )
      end
    end
  end
end
