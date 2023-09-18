# frozen_string_literal: true

module Primer
  module OpenProject
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class DragHandle < Primer::Component
      status :open_project

      DEFAULT_SIZE = Primer::Beta::Octicon::SIZE_DEFAULT
      SIZE_OPTIONS = Primer::Beta::Octicon::SIZE_OPTIONS

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: Primer::OpenProject::DragHandle::DEFAULT_SIZE, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "div"
        @system_arguments[:classes] =
          class_names(
            @system_arguments[:classes],
            "DragHandle"
          )

        @size = fetch_or_fallback(Primer::OpenProject::DragHandle::SIZE_OPTIONS, size, Primer::OpenProject::DragHandle::DEFAULT_SIZE)
      end
    end
  end
end
