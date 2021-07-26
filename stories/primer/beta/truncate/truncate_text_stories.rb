# frozen_string_literal: true

class Primer::Beta::Truncate::TruncateTextStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:item) do
    controls do
      priority false
      expandable false
      max_width nil
    end

    content do
      "Item"
    end
  end
end
