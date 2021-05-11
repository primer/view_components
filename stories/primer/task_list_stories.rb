# frozen_string_literal: true

class Primer::TaskListStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:task_list) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
