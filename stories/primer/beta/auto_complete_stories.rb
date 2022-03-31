# frozen_string_literal: true

require "primer/beta/auto_complete"

class Primer::Beta::AutoCompleteStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete) do
    controls do
      text(:label_text, "Fruits")
      text(:src, "/")
      text(:input_id, "input-id")
      text(:input_name, "input-name")
      text(:list_id, "list-id")
      is_clearable false
      is_label_inline false
      is_label_visible true
      with_icon false
    end
  end
end
