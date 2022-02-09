# frozen_string_literal: true

require "primer/beta/avatar"

class Primer::Beta::AvatarStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar) do
    controls do
      text(:alt, "github")
      text(:src, "https://github.com/github.png")
      size 20
      select(:shape, Primer::Beta::Avatar::SHAPE_OPTIONS, Primer::Beta::Avatar::DEFAULT_SHAPE)
      text(:href, "#")
      object(:link_arguments, {})
    end
  end
end
