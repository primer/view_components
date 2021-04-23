# frozen_string_literal: true

class Primer::BaseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:base) do
    controls do
      block false
      select(:tag, Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE)
    end

    content do
      "Click me"
    end
  end
end
