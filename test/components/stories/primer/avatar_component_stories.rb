# frozen_string_literal: true

class Primer::AvatarComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar) do
    controls do
      text(:alt, "github")
      text(:src, "https://github.com/github.png")
      select(:size, Primer::AvatarComponent::SIZE_MAPPINGS.keys.each_with_object({}) { |k, h| h[k] = k }, 4)
    end
  end
end
