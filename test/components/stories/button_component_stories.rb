# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  story(:primary) do
    controls do
      text(:button_type, "primary")
    end
  end
end
