# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:timeline_item) do
    controls do
      condensed false
    end

    content do |component|
      component.slot(:avatar, alt: "@octocat", src: "https://user-images.githubusercontent.com/334891/29999089-2837c968-9009-11e7-92c1-6a7540a594d5.png")
      component.slot(:badge, bg: :green, color: :white) { "✓" }
      component.slot(:body) { "Success" }
    end
  end
end
