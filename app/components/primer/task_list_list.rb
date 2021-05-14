# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class TaskListList < Primer::Component
    renders_many :items, Primer::TaskListItem

    # @example Example goes here
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments

      @system_arguments[:tag] = :ul
      @system_arguments[:classes] = class_names(system_arguments[:classes], "contains-task-list", "list-style-none")
    end
  end
end
