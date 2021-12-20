# frozen_string_literal: true

require "primer/beta/autocomplete/item"

class Primer::Beta::Autocomplete::ItemStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:autocomplete_item) do
    controls do
      text(:value, "value")
      selected false
      disabled false
    end

    content do
      "<div>An item</div>".html_safe
    end
  end
end
