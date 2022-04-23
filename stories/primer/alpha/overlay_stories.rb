# frozen_string_literal: true

require "primer/alpha/overlay"

class Primer::Alpha::OverlayStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:overlay) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
