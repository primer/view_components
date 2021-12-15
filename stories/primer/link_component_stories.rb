# frozen_string_literal: true

class Primer::LinkComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    constructor(
      href: "https://github.com/",
      muted: boolean(false),
      underline: boolean(true),
      scheme: select(Primer::LinkComponent::SCHEME_MAPPINGS.keys, Primer::LinkComponent::DEFAULT_SCHEME),
      tag: select(Primer::LinkComponent::TAG_OPTIONS, Primer::LinkComponent::DEFAULT_TAG)
    )

    content do
      "This is a link!"
    end
  end
end
