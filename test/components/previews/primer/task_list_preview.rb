# frozen_string_literal: true

module Primer
  class TaskListPreview < ViewComponent::Preview
    def default
      render(Primer::TaskList.new) do |component|
        component.list do |list|
          list.item do
            "Foobar"
          end
        end
      end
    end
  end
end
