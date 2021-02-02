# frozen_string_literal: true

class Primer::ButtonGroupComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_group) do
    content do |component|
      component.button { "Button" }
      component.button { "Button" }
      component.button { "Button" }
      component.button { "Button" }
    end
  end
end
