# frozen_string_literal: true

require "primer/beta/split_layout"

class Primer::Beta::SplitLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:split_layout) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
