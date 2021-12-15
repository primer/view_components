# frozen_string_literal: true

require "primer/beta/avatar"

class Primer::Beta::AvatarStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar) do
    constructor(
      alt: text("github"),
      src: text("https://github.com/github.png"),
      size: 20,
      shape: select(Primer::Beta::Avatar::SHAPE_OPTIONS, Primer::Beta::Avatar::DEFAULT_SHAPE),
      href: text("#")
    )
  end
end
