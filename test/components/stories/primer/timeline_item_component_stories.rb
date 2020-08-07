# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:timeline_item) do
    controls do
      condensed false
    end

    content do |component|
      component.slot(:badge, bg: :green, color: :white, icon: :check)
      component.slot(:body) { "Success" }
    end
  end
end
