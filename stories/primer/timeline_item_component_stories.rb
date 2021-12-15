# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:timeline_item) do
    constructor(condensed: boolean(false))

    avatar(src: "https://github.com/github.png", alt: "github")
    badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
    body { "Success" }
  end
end
