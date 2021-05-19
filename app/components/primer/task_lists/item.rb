# frozen_string_literal: true

module Primer
  module TaskLists
    # This component is part of `TaskLists` and should not be
    # used as a standalone component.
    class Item < Primer::Component
      def initialize(**system_arguments)
        @system_arguments = system_arguments

        @system_arguments[:tag] = :li
        @system_arguments[:classes] = class_names(@system_arguments[:classes], "task-list-item")
      end
    end
  end
end
