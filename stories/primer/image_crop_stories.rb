# frozen_string_literal: true

class Primer::ImageCropStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image_crop) do
    constructor(
      src: text("https://github.com/koddsson.png"),
      style: text("width: 500px")
    )
  end

  story(:image_crop_with_custom_loading_slot) do
    constructor(
      src: text("https://github.com/koddsson.png"),
      style: text("width: 500px")
    )

    loading { "Loading.." }
  end
end
