# frozen_string_literal: true

class Primer::TextComponentStories < ViewComponent::Storybook::Stories
  layout layout "storybook_preview"

  story(:text) do
    content do
      "text"
    end
  end
end
