# frozen_string_literal: true

module Primer
  # Add a general description of component here
  # Add additional usage considerations or best practices that may aid the user to use the component correctly.
  # @accessibility Add any accessibility considerations
  class TaskListComponent < Primer::Component
    renders_many :lists, Primer::TaskList::List

    # @example Example goes here
    #
    #   <%= render(Primer::TaskListComponent.new) do |component| %>
    #     <% component.lists([{content: "Item"}]) %>
    #   <% end %>
    #
    # @param sortable [Boolean] TODO
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(sortable: false, **system_arguments)
      @system_arguments = system_arguments

      @system_arguments[:tag] = :"task-lists"
      @system_arguments[:sortable] = true if sortable
    end
  end
end
