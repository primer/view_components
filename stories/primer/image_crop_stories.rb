# frozen_string_literal: true

class Primer::ImageCropStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image_crop) do
    controls do
      text(:src, "https://github.com/koddsson.png")
      text(:style, "width: 500px")
    end
  end

  story(:image_crop_with_custom_loading_slot) do
    controls do
      text(:src, "https://github.com/koddsson.png")
      text(:style, "width: 500px")
    end

    content do |component|
      component.loading do
        "Loading.."
      end
    end
  end
end
