# frozen_string_literal: true

require "primer/alpha/dialog"

class Primer::Alpha::DialogStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:dialog) do
    controls do
      classes "custom-class"
      title "Are you sure you want to display a dialog?"
    end

    content do |component|
      component.show_button do
        "Show dialog"
      end
      component.body do
        "Your custom content here"
      end
      component.button { "Yes" }
      component.button { "No" }
    end
  end
end
