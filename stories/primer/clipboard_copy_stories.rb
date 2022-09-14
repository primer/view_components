# frozen_string_literal: true

class Primer::ClipboardCopyStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:clipboard_copy_simple) do
    controls do
      text(:value, "Text to copy")
      aria(label: "Copy text to the system clipboard")
    end

    content
  end

  story(:clipboard_copy_text) do
    controls do
      text(:value, "Text to copy")
      aria(label: "Copy text to the system clipboard")
    end

    content do
      "Click to copy!"
    end
  end
end
