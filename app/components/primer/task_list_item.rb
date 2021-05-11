# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class TaskListItem < Primer::Component
    def initialize(**system_arguments)
      @system_arguments = system_arguments

      @system_arguments[:tag] = :li
      @system_arguments[:classes] = class_names(@system_arguments[:classes], "task-list-item")

      Primer::BaseComponent.new(**@system_arguments)
    end
  end
end
