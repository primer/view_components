# frozen_string_literal: true

class Primer::Button::LinkStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    controls do
      block false
      select(:type, Primer::Button::Base::TYPE_OPTIONS, Primer::Button::Base::DEFAULT_TYPE)
    end
  end
end
