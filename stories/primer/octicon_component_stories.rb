# frozen_string_literal: true

class Primer::OcticonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:octicon) do
    constructor(
      icon: text("people"),
      size: select(Primer::OcticonComponent::SIZE_MAPPINGS.keys, :small)
    )
  end
end
