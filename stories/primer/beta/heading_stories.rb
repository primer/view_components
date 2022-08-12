# frozen_string_literal: true

require "primer/beta/heading"

class Primer::Beta::HeadingStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:heading) do
    controls do
      select(:tag, Primer::Beta::Heading::TAG_OPTIONS, Primer::Beta::Heading::TAG_FALLBACK)
    end

    content do
      "This is a heading!"
    end
  end
end
