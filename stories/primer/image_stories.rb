# frozen_string_literal: true

class Primer::ImageStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:image) do
    constructor(
      classes: "",
      src: "https://github.com/github.png",
      alt: text("The GitHub logo"),
      height: number(100),
      width: number(100),
      lazy: boolean(false)
    )
  end
end
