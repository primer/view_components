# frozen_string_literal: true

require "primer/beta/autocomplete"

class Primer::Beta::AutocompleteStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:autocomplete) do
    controls do
      text(:src, "/")
      text(:input_id, "input-id")
      text(:list_id, "list-id")
    end

    content do |c|
      c.label { "Fruits" }
      c.input(name: "username")
      c.icon(icon: :search)
    end
  end
end
