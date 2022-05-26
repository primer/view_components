# frozen_string_literal: true

class Primer::TimelineItemComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:timeline_item) do
    controls do
      condensed false
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.badge(bg: :success_emphasis, color: :on_emphasis, icon: :check)
      component.body { "Success" }
    end
  end
end
