# frozen_string_literal: true

class Primer::BorderBoxComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:full_box) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    header { "Header" }
    body { "Body" }
    row { "Row one" }
    row { "Row two" }
    row { "Row three" }
    footer { "Footer" }
  end

  story(:header) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    header { "Header" }
  end

  story(:header_title) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    header(title: "Title")
  end

  story(:body) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    body { "Body" }
  end

  story(:footer) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    footer { "Footer" }
  end

  story(:rows) do
    constructor(
      padding: select(Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    )

    row { "Row one" }
    row { "Row two" }
    row { "Row three" }
  end
end
