# frozen_string_literal: true

class Primer::Breadcrumb::ItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  self.title = "Primer/Breadcrumb Component/Item"

  story(:with_items) do
    controls do
      text(:href, "#")
      selected false
    end

    content do
      "Item"
    end
  end
end
