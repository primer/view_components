# frozen_string_literal: true

class Primer::IconButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon_button) do
    controls do
      aria(label: "Button label")
      icon "star"
      box false
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, Primer::Beta::BaseButton::DEFAULT_TAG)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, Primer::Beta::BaseButton::DEFAULT_TYPE)
      select(:scheme, Primer::IconButton::SCHEME_OPTIONS, Primer::IconButton::DEFAULT_SCHEME)
    end
  end
end
