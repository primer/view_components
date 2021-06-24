# frozen_string_literal: true

class Primer::IconButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon_button) do
    controls do
      text(:"aria-label", "button label")
      icon "star"
      box false
      select(:tag, Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE)
      select(:scheme, Primer::IconButton::SCHEME_OPTIONS, Primer::IconButton::DEFAULT_SCHEME)
    end
  end
end
