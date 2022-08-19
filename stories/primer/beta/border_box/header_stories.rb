# frozen_string_literal: true

require "primer/beta/border_box/header"

class Primer::Beta::BorderBox::HeaderStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:default) do
    content do
      "Header"
    end
  end

  story(:with_title) do
    content do |component|
      component.title(tag: :h2) { "Title" }
    end
  end
end
