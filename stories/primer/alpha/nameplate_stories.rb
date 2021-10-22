# frozen_string_literal: true

require "primer/alpha/nameplate"

class Primer::Alpha::NameplateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:nameplate) do
    controls do
      username "github"
      full_name ""
      select(:tag, Primer::Alpha::Nameplate::TAG_OPTIONS, Primer::Alpha::Nameplate::DEFAULT_TAG)
      href "#"
    end

    content do |c|
      c.avatar(src: "https://github.com/github.png")
    end
  end
end
