# frozen_string_literal: true

class Primer::ImageStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image) do
    controls do
      classes ""
      src "https://github.com/github.png"
      alt "The GitHub logo"
      height 100
      width 100
      lazy false
    end
  end
end
