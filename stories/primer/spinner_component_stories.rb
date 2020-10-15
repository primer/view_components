# frozen_string_literal: true

class Primer::SpinnerComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:spinner) do
    controls do
      text(:title, "github")
    end
  end
end
  