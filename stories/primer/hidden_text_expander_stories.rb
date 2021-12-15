# frozen_string_literal: true

class Primer::HiddenTextExpanderStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:hidden_text_expander) do
    constructor(inline: boolean(false), "aria-label": "No action")
  end
end
