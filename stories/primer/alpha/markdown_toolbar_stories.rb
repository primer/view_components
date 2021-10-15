# frozen_string_literal: true

require "primer/alpha/markdown_toolbar"

class Primer::Alpha::MarkdownToolbarStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:markdown_toolbar) do
    controls do
      classes "custom-class"
    end

    content do |c|
      c.prepend_buttons()
      c.append_buttons()
    end
  end
end
