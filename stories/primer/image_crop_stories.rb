# frozen_string_literal: true

class Primer::ImageCropStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image_crop) do
    controls do
      text(:src, "https://github.com/koddsson.png")
      text(:style, "width: 500px")
    end

    content
  end
end
