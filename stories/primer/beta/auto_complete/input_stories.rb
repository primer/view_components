# frozen_string_literal: true

require "primer/beta/auto_complete"

class Primer::Beta::AutoComplete::InputStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete_input) do
    constructor(type: text("text"), "aria-label": "Search fruits")
  end
end
