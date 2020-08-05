# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:timeline_item) do
    controls do
      condensed false
    end

    content do |component|
      component.slot(:badge, bg: :green, color: :white) { "✓" }
      component.slot(:body) { "Success" }
    end
  end
end
