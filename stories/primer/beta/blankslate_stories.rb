# frozen_string_literal: true

require "primer/beta/blankslate"

class Primer::Beta::BlankslateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      visual_icon(icon: :shield)
      heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end

  story(:image) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      heading(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
      visual_image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault")
    end
  end

  story(:loading) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      heading(tag: :h2).with_content("Mirroring your repository")
      description { "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository." }
      visual_spinner(size: :large)
    end
  end

  story(:description) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      description { "Millions of teams trust GitHub to keep their work safe" }
    end
  end

  story(:primary_action) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      primary_action(href: "#").with_content("Fix issue")
    end
  end

  story(:secondary_action) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      secondary_action(href: "#").with_content("Fix issue")
    end
  end

  story(:full) do
    constructor(narrow: false, spacious: false, border: false)

    content do
      visual_icon(icon: :shield)
      heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      description { "Millions of teams trust GitHub to keep their work safe" }
      primary_action(href: "#").with_content("Fix issue")
      secondary_action(href: "#").with_content("Learn more about vulnerabilities")
    end
  end
end
