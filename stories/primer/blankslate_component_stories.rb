# frozen_string_literal: true

class Primer::BlankslateComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    constructor(
      icon: "shield",
      title: "It looks like we have discovered a vulnerability",
      icon_size: select(Primer::OcticonComponent::SIZE_MAPPINGS.keys, :medium)
    )
  end

  story(:image_src) do
    constructor(
      image_src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg",
      image_alt: "Security - secure vault",
      title: "Millions of teams trust GitHub to keep their work safe"
    )
  end

  story(:loading) do
    constructor(
      title: "Mirroring your repository",
      description: "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository."
    )

    spinner(size: :large)
  end

  story(:description) do
    constructor(
      title: "It looks like we have discovered a vulnerability",
      description: "Millions of teams trust GitHub to keep their work safe"
    )
  end

  story(:button) do
    constructor(
      title: "It looks like we have discovered a vulnerability",
      button_text: "Fix issue",
      button_url: "#"
    )
  end

  story(:link) do
    constructor(
      title: "It looks like we have discovered a vulnerability",
      link_text: "Fix issue",
      link_url: "#"
    )
  end
end
