# frozen_string_literal: true

require "primer/alpha/tooltip"

class Primer::Alpha::TooltipStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
