# frozen_string_literal: true

require "primer/beta/blankslate"

class Primer::Beta::BlankslateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.visual_icon(icon: :shield)
      c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end

  story(:image) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.heading(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
      c.visual_image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault")
    end
  end

  story(:loading) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.heading(tag: :h2).with_content("Mirroring your repository")
      c.description { "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository." }
      c.visual_spinner(size: :large)
    end
  end

  story(:description) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.description { "Millions of teams trust GitHub to keep their work safe" }
    end
  end

  story(:primary_action) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.primary_action(href: "#").with_content("Fix issue")
    end
  end

  story(:secondary_action) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.secondary_action(href: "#").with_content("Fix issue")
    end
  end

  story(:full) do
    controls do
      narrow false
      spacious false
      border false
    end

    content do |c|
      c.visual_icon(icon: :shield)
      c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
      c.description { "Millions of teams trust GitHub to keep their work safe" }
      c.primary_action(href: "#").with_content("Fix issue")
      c.secondary_action(href: "#").with_content("Learn more about vulnerabilities")
    end
  end
end
