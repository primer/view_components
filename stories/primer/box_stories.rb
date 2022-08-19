# frozen_string_literal: true

require "primer/box"

class Primer::BoxStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:box) do
    content do
      "This is a div"
    end
  end
end
