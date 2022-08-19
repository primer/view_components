# frozen_string_literal: true

require "primer/alpha/hidden_text_expander"

class Primer::Alpha::HiddenTextExpanderStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:hidden_text_expander) do
    controls do
      inline false
      aria(label: "No action")
    end
  end
end
