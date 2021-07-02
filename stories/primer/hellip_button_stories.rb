# frozen_string_literal: true

class Primer::HellipButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:hellip_button) do
    controls do
      inline false
      aria(label: "No action")
    end
  end
end
