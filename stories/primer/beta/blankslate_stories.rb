# frozen_string_literal: true

require "primer/beta/blankslate"

class Primer::Beta::BlankslateStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    controls do
      icon "shield"
      select(:icon_size, Primer::OcticonComponent::SIZE_MAPPINGS.keys, :medium)
    end

    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end

  story(:image_src) do
    controls do
      image_src "https://github.githubassets.com/images/modules/site/features/security-icon.svg"
      image_alt "Security - secure vault"
    end

    content do |c|
      c.title(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
    end
  end

  story(:loading) do
    controls do
      description "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository."
    end

    content do |c|
      c.title(tag: :h2).with_content("Mirroring your repository")
      c.spinner(size: :large)
    end
  end

  story(:description) do
    controls do
      description "Millions of teams trust GitHub to keep their work safe"
    end

    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
    end
  end

  story(:button) do
    controls do
      button_text "Fix issue"
      button_url "#"
    end

    content do |c|
      c.title(tag: :h2).with_content("It looks like we have discovered a vulnerability")
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
