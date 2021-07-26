# frozen_string_literal: true

require "primer/alpha/button_marketing"

class Primer::Beta::TruncateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:truncate) do
    content do |component|
      component.text { "Truncate text" }
    end
  end
end
