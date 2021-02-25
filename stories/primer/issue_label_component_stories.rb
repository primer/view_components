# frozen_string_literal: true

class Primer::IssueLabelComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:issue_label) do
    controls do
      select(:variant, Primer::IssueLabelComponent::VARIANT_MAPPINGS.keys, :default)
      text(:bg, "blue")
      text(:text, "white")
    end

    content do
      "This is a label"
    end
  end
end
