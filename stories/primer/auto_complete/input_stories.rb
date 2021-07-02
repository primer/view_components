# frozen_string_literal: true

class Primer::AutoComplete::InputStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete_input) do
    controls do
      text(:type, "text")
      aria(label: "Search fruits")
    end
  end
end
