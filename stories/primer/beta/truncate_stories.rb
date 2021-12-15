# frozen_string_literal: true

require "primer/beta/truncate"

class Primer::Beta::TruncateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:truncate) do
    content(text("Truncate text"))
  end
end
