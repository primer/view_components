# frozen_string_literal: true

class Primer::CloseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:close_button) do
    controls do
      select(:type, Primer::CloseButton::TYPE_OPTIONS, Primer::CloseButton::DEFAULT_TYPE)
    end
  end
end
