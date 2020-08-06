# frozen_string_literal: true

class Primer::AvatarComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar) do
    controls do
      text(:alt, "github")
      text(:src, "https://github.com/github.png")
      size 20
      square false
    end
  end
end
