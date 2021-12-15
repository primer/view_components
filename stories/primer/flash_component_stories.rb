# frozen_string_literal: true

class Primer::FlashComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:flash) do
    constructor(
      icon: "people",
      scheme: select(Primer::FlashComponent::SCHEME_MAPPINGS.keys, :default),
      full: boolean(false),
      spacious: boolean(false),
      dismissible: boolean(false)
    )

    content do
      "This is a flash message!"
    end
  end
end
