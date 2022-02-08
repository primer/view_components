# frozen_string_literal: true

require "primer/alpha/dialog"

class Primer::Alpha::DialogStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:dialog) do
    controls do
      classes ""
      title "This is the title of the dialog"
      description "This is the description of the dialog"
    end

    content do |component|
      component.show_button do
        "Show dialog"
      end
      component.body do
        "This is the body of the dialog"
      end
      component.button { "Yes" }
      component.button { "No" }
    end
  end
end
