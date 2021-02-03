# frozen_string_literal: true

class Primer::ButtonGroupComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_group) do
    content do |c|
      c.button { "Button" }
      c.button(button_type: :primary) { "Primary" }
      c.button(button_type: :danger) { "Danger" }
      c.button(button_type: :outline) { "Outline" }
    end
  end
end
