# frozen_string_literal: true

class Primer::CloseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:close_button) do
    constructor(type: select(Primer::CloseButton::TYPE_OPTIONS, Primer::CloseButton::DEFAULT_TYPE))
  end
end
