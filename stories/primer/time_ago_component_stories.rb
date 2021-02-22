# frozen_string_literal: true

class Primer::TimeAgoComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:time_ago) do
    controls do
      time Time.zone.now
    end
  end
end
