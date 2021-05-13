# frozen_string_literal: true

class Primer::ImageStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
