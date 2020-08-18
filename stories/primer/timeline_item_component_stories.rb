# frozen_string_literal: true

class Primer::TimelineItemComponentStories < Primer::Stories
  layout "storybook_centered_preview"

  story(:timeline_item) do
    controls do
      condensed false
    end

    content do |component|
      component.slot(:avatar, src: "https://github.com/github.png", alt: "github")
      component.slot(:badge, bg: :green, color: :white, icon: :check)
      component.slot(:body) { "Success" }
    end
  end
end
