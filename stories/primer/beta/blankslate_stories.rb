# frozen_string_literal: true

require "primer/beta/blankslate"

class Primer::Beta::BlankslateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    content do |c|
      c.icon(icon: :shield)
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end

  story(:image) do
    content do |c|
      c.title(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
      c.image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault")
    end
  end

  story(:loading) do
    content do |c|
      c.title(tag: :h2).with_content("Mirroring your repository")
      c.description { "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository." }
      c.spinner(size: :large)
    end
  end

  story(:description) do
    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.description { "Millions of teams trust GitHub to keep their work safe" }
    end
  end

  story(:button) do
    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.button(href: "#").with_content("Fix issue")
    end
  end

  story(:link) do
    controls do
      link_text "Fix issue"
      link_url "#"
    end

    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end
end
