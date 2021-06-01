# frozen_string_literal: true

require "primer/auto_complete/input"

class Primer::AutoComplete::InputStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete_input) do
    controls do
      text(:type, "text")
    end
  end
end
