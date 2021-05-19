# frozen_string_literal: true

module Primer
  # Drag and droppable task list items.
  class TaskListsComponent < Primer::Component
    renders_many :lists, Primer::TaskLists::List

    # @example Simple
    #
    #   <%= render(Primer::TaskListsComponent.new) do |component| %>
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
