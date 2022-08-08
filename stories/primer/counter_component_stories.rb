# frozen_string_literal: true

class Primer::CounterComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:counter) do
    controls do
      count 0
      select(:scheme, Primer::CounterComponent::SCHEME_MAPPINGS.keys, :primary)
      limit 5000
      hide_if_zero false
      round false
    end
  end
end
