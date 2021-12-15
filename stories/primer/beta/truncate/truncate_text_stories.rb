# frozen_string_literal: true

require "primer/beta/truncate"

class Primer::Beta::Truncate::TruncateTextStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:item) do
    constructor(
      priority: boolean(false),
      expandable: boolean(false),
      max_width: number(125)
    )

    content do
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    end
  end
end
