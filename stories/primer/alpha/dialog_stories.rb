# frozen_string_literal: true

require "primer/alpha/dialog"

class Primer::Alpha::DialogStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:dialog) do
    controls do
      classes "custom-class"
      title "Are you sure you want to display a dialog?"
    end

    content do
      "Update your stories!"
    end
  end
end
