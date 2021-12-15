# frozen_string_literal: true

class Primer::SpinnerComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:spinner) do
    constructor(size: select(Primer::SpinnerComponent::SIZE_OPTIONS, :medium))
  end
end
