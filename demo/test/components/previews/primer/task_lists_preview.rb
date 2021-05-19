# frozen_string_literal: true

module Primer
  class TaskListsPreview < ViewComponent::Preview
    def default
      render(Primer::TaskListsComponent.new(sortable: true)) do |component|
        component.list do |list|
          list.item do
            "Apple"
          end
          list.item do
            "Kiwi"
          end
          list.item do
            "Banana"
          end
        end
      end
    end
  end
end
