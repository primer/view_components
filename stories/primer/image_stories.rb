# frozen_string_literal: true

class Primer::ImageStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image) do
    controls do
      classes "custom-class"
      src "https://github.com/github.png"
      alt "image description"
      height 100
      width 100
      select(:loading, Primer::Image::LOADING_OPTIONS, Primer::Image::DEFAULT_LOADING)
    end

    content do
      "Update your stories!"
    end
  end
end
