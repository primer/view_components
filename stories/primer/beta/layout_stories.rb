# frozen_string_literal: true

require "primer/beta/layout"

class Primer::Beta::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
