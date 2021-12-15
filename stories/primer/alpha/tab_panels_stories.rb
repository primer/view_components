# frozen_string_literal: true

require "primer/alpha/tab_panels"

class Primer::Alpha::TabPanelsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_panels) do
    constructor(label: "custom-label")

    content do
      "Update your stories!"
    end
  end
end
