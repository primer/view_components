# frozen_string_literal: true

class Primer::SpinnerComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:spinner) do
    controls do
      size 32
    end
  end
end
