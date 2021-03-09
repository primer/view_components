# frozen_string_literal: true

class Primer::LinkComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    controls do
      href "https://github.com/"
      muted false
      underline true
    end

    content do
      "This is a link!"
    end
  end
end
