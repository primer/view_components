# frozen_string_literal: true

class Primer::ClipboardCopyStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:clipboard_copy_simple) do
    constructor(
      value: text("Text to copy"),
      "aria-label": "Copy text to the system clipboard"
    )
  end

  story(:clipboard_copy_text) do
    constructor(
      value: text("Text to copy"),
      "aria-label": "Copy text to the system clipboard"
    )

    content do
      "Click to copy!"
    end
  end
end
