# frozen_string_literal: true

class Primer::IconButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon_button) do
    constructor(
      "aria-label": "Button label",
      icon: "star",
      box: boolean(false),
      tag: select(Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG),
      type: select(Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE),
      scheme: select(Primer::IconButton::SCHEME_OPTIONS, Primer::IconButton::DEFAULT_SCHEME)
    )
  end
end
