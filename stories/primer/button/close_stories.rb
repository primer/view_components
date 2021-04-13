# frozen_string_literal: true

class Primer::Button::CloseStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:close) do
    controls do
      select(:type, Primer::Button::Close::TYPE_OPTIONS, Primer::Button::Close::DEFAULT_TYPE)
    end
  end
end
