# frozen_string_literal: true

class Primer::HiddenTextExpanderStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:hidden_text_expander) do
    controls do
      inline false
      text("aria-label", "Copy text to the system clipboard")
    end
  end
end
