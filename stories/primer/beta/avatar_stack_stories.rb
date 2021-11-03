# frozen_string_literal: true

require "primer/beta/avatar_stack"

class Primer::Beta::AvatarStackStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar_stack) do
    controls do
      select(:align, Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end

  story(:three_plus) do
    controls do
      select(:align, Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end

  story(:tooltipped_body) do
    controls do
      select(:align, Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
      tooltipped true
      body_arguments(label: "This is a tooltip")
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end

  story(:linked) do
    controls do
      select(:align, Primer::Beta::AvatarStack::ALIGN_OPTIONS, Primer::Beta::AvatarStack::ALIGN_DEFAULT)
    end

    content do |component|
      component.avatar(href: "#", src: "https://github.com/github.png", alt: "github")
      component.avatar(href: "#", src: "https://github.com/github.png", alt: "github")
      component.avatar(href: "#", src: "https://github.com/github.png", alt: "github")
    end
  end
end
