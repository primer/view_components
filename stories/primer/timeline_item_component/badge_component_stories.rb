# frozen_string_literal: true

class Primer::TimelineItemComponent::BadgeComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:with_items) do
    constructor(icon: text("people"))
  end
end
