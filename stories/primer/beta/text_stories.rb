# frozen_string_literal: true

require "primer/beta/text"

class Primer::Beta::TextStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:text) do
    content do
      "text"
    end
  end
end
