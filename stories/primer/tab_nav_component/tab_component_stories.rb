# frozen_string_literal: true

class Primer::TabNavComponent::TabComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:tab) do
    controls do
      text(:title, "Tab")
      selected true
      select(:tag, [:a, :button], :a)
    end
  end
end
