# frozen_string_literal: true

require "primer/alpha/action_menu"

class Primer::Alpha::ActionMenuStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:action_menu) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
