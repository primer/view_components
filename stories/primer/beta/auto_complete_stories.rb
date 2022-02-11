# frozen_string_literal: true

require "primer/beta/auto_complete"

class Primer::Beta::AutoCompleteStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete) do
    controls do
      text(:label_text, "Fruits")
      text(:src, "/")
      text(:input_id, "input-id")
      text(:list_id, "list-id")
    end

    content do |c|
      c.icon(icon: :search)
    end
  end
end
