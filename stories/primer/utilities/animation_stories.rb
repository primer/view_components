# frozen_string_literal: true

class Primer::Utilities::AnimationStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  def self.default_component
    Primer::BoxComponent
  end

  story(:animation) do
    constructor(
      animation: select([:fade_in, :fade_out, :fade_up, :fade_down, :scale_in, :pulse, :grow_x, :hover_grow], :fade_in)
    )

    content do
      render Primer::OcticonComponent.new(icon: :"mark-github", size: :medium)
    end
  end
end
