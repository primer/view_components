# frozen_string_literal: true

class Primer::BreadcrumbComponent::ItemStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:item) do
    controls do
      text(:href, "#")
      selected false
    end

    content do
      "Item"
    end
  end
end
