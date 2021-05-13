# frozen_string_literal: true

class Primer::TaskListStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:task_list) do
    content do |c|
      c.list do |list|
        list.item do
          "Item 1"
        end
      end
    end
  end
end
