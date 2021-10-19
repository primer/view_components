# frozen_string_literal: true

require "primer/alpha/border_box_header"

class Primer::Alpha::BorderBoxHeaderStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:border_box_header) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
