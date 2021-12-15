# frozen_string_literal: true

require "primer/beta/auto_complete/item"

class Primer::Beta::AutoComplete::ItemStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete_item) do
    constructor(
      value: text("value"),
      selected: boolean(false),
      disabled: boolean(false)
    )

    content do
      "<div>An item</div>".html_safe
    end
  end
end
