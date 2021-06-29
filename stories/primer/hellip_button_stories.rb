# frozen_string_literal: true

class Primer::HellipButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:hellip_button) do
    controls do
      inline false
    end
  end
end
