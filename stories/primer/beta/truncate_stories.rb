# frozen_string_literal: true

require "primer/beta/truncate"

class Primer::Beta::TruncateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:truncate) do
    content do |component|
      component.item { "Truncate text" }
    end
  end
end
