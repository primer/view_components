# frozen_string_literal: true

require "primer/beta/avatar_stack"

class Primer::Beta::AvatarStackStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar_stack) do
    constructor(
      align: select(Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    )

    avatar(src: "https://github.com/github.png", alt: "github")
    avatar(src: "https://github.com/github.png", alt: "github")
  end

  story(:three_plus) do
    constructor(
      align: select(Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    )

    avatar(src: "https://github.com/github.png", alt: "github")
    avatar(src: "https://github.com/github.png", alt: "github")
    avatar(src: "https://github.com/github.png", alt: "github")
    avatar(src: "https://github.com/github.png", alt: "github")
  end

  story(:tooltipped_body) do
    constructor(
      align: select(Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT),
      tooltipped: true,
      body_arguments: { label: "This is a tooltip" }
    )

    avatar(src: "https://github.com/github.png", alt: "github")
    avatar(src: "https://github.com/github.png", alt: "github")
  end

  story(:linked) do
    constructor(
      align: select(Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    )

    avatar(href: "#", src: "https://github.com/github.png", alt: "github")
    avatar(href: "#", src: "https://github.com/github.png", alt: "github")
    avatar(href: "#", src: "https://github.com/github.png", alt: "github")
  end
end
