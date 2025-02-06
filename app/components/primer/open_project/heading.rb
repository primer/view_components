# frozen_string_literal: true

module Primer
  module OpenProject
    # This is a generic Heading component specifically for the use in the OpenProject context
    # Use it for any Heading you need **inside** the page context.
    # Do not use for a page header, we have Primer::OpenProject::PageHeader for that
    class Heading < Primer::Component
      status :open_project

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments

        # Override because of Primer::OpenProject::PageHeader which should be the
        # most prominent element in the hierarchical structure
        @system_arguments[:font_weight] ||= :normal
      end

      def call
        render(Primer::Beta::Heading.new(**@system_arguments)) { content }
      end
    end
  end
end
