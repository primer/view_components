# frozen_string_literal: true

class Primer::ProgressBarComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:progress_bar) do
    constructor(size: select(Primer::ProgressBarComponent::SIZE_MAPPINGS.keys, :small))

    item(bg: :success_emphasis, percentage: 10)
  end
end
