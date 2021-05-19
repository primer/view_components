# frozen_string_literal: true

class Primer::TaskListComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:task_list) do
    controls do
      boolean(:sortable, true)
    end

    content do |component|
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
