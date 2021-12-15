# frozen_string_literal: true

class Primer::ButtonGroupStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_group) do
    constructor(
      variant: select(Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
    )

    button { "Button" }
    button(scheme: :primary) { "Primary" }
    button(scheme: :danger) { "Danger" }
    button(scheme: :outline) { "Outline" }
  end
end
