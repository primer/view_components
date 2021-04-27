# frozen_string_literal: true

class Primer::LocalTimeStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:local_time) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
