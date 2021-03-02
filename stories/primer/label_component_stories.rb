# frozen_string_literal: true

class Primer::LabelComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:label) do
    controls do
      title "this is a label"
      # TODO: Update to use functional scheme mappings
      select(:scheme, Primer::LabelComponent::SCHEME_MAPPINGS.keys, :success)
      select(:variant, Primer::LabelComponent::VARIANT_MAPPINGS.keys, :large)
    end

    content do
      "This is a label"
    end
  end
end
