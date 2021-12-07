# frozen_string_literal: true

require "primer/beta/page_layout"

class Primer::Beta::PageLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
