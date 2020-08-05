# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:timeline_item) do
    content do |component|
      component.slot(:badge) { "Badge" }
      component.slot(:body) { "Body" }
    end
  end
end
