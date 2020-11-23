# frozen_string_literal: true

class Primer::SelectMenuBlankslateComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:select_menu_blankslate) do
    content do
      "No matching results"
    end
  end
end
