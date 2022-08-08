# frozen_string_literal: true

require "primer/beta/counter"

class Primer::Beta::CounterStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:counter) do
    controls do
      count 0
      select(:scheme, Primer::Beta::Counter::SCHEME_MAPPINGS.keys, :primary)
      limit 5000
      hide_if_zero false
      round false
    end
  end
end
