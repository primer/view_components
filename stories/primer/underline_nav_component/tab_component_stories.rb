# frozen_string_literal: true

class Primer::UnderlineNavComponent::TabComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab) do
    controls do
      selected true
      href "#"
    end

    content do
      "Tab"
    end
  end
end
