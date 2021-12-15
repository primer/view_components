# frozen_string_literal: true

class Primer::LabelComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:label) do
    constructor(
      scheme: select(Primer::LabelComponent::SCHEME_MAPPINGS.keys, :success),
      variant: select(Primer::LabelComponent::VARIANT_MAPPINGS.keys, :large)
    )

    content do
      "This is a label"
    end
  end
end
