# frozen_string_literal: true

module Primer
  class TaskListPreview < ViewComponent::Preview
    def default
      render(Primer::TaskList.new(sortable: true)) do |component|
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
