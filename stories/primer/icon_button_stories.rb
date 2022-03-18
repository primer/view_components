# frozen_string_literal: true

class Primer::IconButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon_button) do
    controls do
      aria(label: "Favorite")
      icon "star"
      box false
      select(:tag, Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE)
      select(:scheme, Primer::IconButton::SCHEME_OPTIONS, Primer::IconButton::DEFAULT_SCHEME)
      select(:tooltip_direction, Primer::Alpha::Tooltip::DIRECTION_OPTIONS, :s)
    end
  end
  story(:icon_button_with_description) do
    controls do
      aria(label: "Favorite")
      aria(description: "Mark as a favorite, Cmd+f")
      icon "star"
      box false
      select(:tag, Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE)
      select(:scheme, Primer::IconButton::SCHEME_OPTIONS, Primer::IconButton::DEFAULT_SCHEME)
      select(:tooltip_direction, Primer::Alpha::Tooltip::DIRECTION_OPTIONS, :s)
    end
  end
end
