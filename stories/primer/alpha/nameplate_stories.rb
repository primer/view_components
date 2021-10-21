# frozen_string_literal: true

require "primer/alpha/nameplate"

class Primer::Alpha::NameplateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:nameplate) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
