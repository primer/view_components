# frozen_string_literal: true

module Primer
  module TaskLists
    # This component is part of `TaskLists` and should not be
    # used as a standalone component.
    class List < Primer::Component
      renders_many :items, Primer::TaskLists::Item

      def initialize(**system_arguments)
        @system_arguments = system_arguments

        @system_arguments[:tag] = :ul
        @system_arguments[:classes] = class_names(system_arguments[:classes], "contains-task-list", "list-style-none")
      end
    end
  end
end
