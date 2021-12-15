# frozen_string_literal: true

class Primer::CounterComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:counter) do
    constructor(
      count: number(0),
      scheme: select(Primer::CounterComponent::SCHEME_MAPPINGS.keys, :primary),
      limit: 5000,
      hide_if_zero: boolean(false),
      round: boolean(false)
    )
  end
end
