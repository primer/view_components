# frozen_string_literal: true

require "primer/alpha/dialog"

class Primer::Alpha::DialogStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:dialog) do
    controls do
      title "github"
      description ""
      select(:tag, Primer::Alpha::Dialog::TAG_OPTIONS, Primer::Alpha::Dialog::DEFAULT_TAG)
      href "#"
    end

    content
  end
end
