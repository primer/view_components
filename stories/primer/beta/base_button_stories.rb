# frozen_string_literal: true

require "primer/beta/base_button"

class Primer::Beta::BaseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:base) do
    controls do
      block false
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, Primer::Beta::BaseButton::DEFAULT_TAG)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, Primer::Beta::BaseButton::DEFAULT_TYPE)
    end

    content do
      "Click me"
    end
  end
end
