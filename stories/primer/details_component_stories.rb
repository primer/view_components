# frozen_string_literal: true

class Primer::DetailsComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:details) do
    constructor(
      overlay: select(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none),
      reset: boolean(false)
    )

    summary { "Click me" }
    body { "Body" }
  end

  story(:custom_button) do
    constructor(overlay: select(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none))

    summary(variant: :small, scheme: :primary) { "Click me" }
    body { "Body" }
  end

  story(:without_button) do
    constructor(overlay: select(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none))

    summary(button: false) { "Click me" }
    body { "Body" }
  end
end
