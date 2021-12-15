# frozen_string_literal: true

require "primer/beta/auto_complete"

class Primer::Beta::AutoCompleteStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete) do
    constructor(
      src: text("/"),
      input_id: text("input-id"),
      list_id: text("list-id")
    )

    label { "Fruits" }
    input(name: "username")
    icon(icon: :search)
  end
end
