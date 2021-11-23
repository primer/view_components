# frozen_string_literal: true

class Primer::LabelComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:label) do
    controls do
      select(:scheme, Primer::LabelComponent::SCHEME_OPTIONS, Primer::LabelComponent::DEFAULT_SCHEME)
      select(:variant, Primer::LabelComponent::VARIANT_MAPPINGS.keys, :large)
    end

    content do
      "This is a label"
    end
  end
end
