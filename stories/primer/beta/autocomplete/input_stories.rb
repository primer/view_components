# frozen_string_literal: true

require "primer/beta/autocomplete"

class Primer::Beta::Autocomplete::InputStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:autocomplete_input) do
    controls do
      text(:type, "text")
      aria(label: "Search fruits")
    end
  end
end
