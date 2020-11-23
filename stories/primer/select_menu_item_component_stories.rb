# frozen_string_literal: true

class Primer::SelectMenuItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:select_menu_item) do
    content do
      "Item 1"
    end
  end
end
