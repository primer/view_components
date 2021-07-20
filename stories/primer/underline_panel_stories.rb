# frozen_string_literal: true

class Primer::UnderlinePanelStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_panel) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
