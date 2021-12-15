# frozen_string_literal: true

class Primer::BaseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:base) do
    constructor(
      block: boolean(false),
      tag: select(Primer::BaseButton::TAG_OPTIONS, Primer::BaseButton::DEFAULT_TAG),
      type: select(Primer::BaseButton::TYPE_OPTIONS, Primer::BaseButton::DEFAULT_TYPE)
    )

    content do
      "Click me"
    end
  end
end
