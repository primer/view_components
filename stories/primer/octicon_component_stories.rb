# frozen_string_literal: true

class Primer::OcticonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:octicon) do
    controls do
      text(:icon, "people")
      select(:size, Primer::StoriesHelper.array_to_options(Primer::OcticonComponent::SIZE_MAPPINGS.keys), :small)
    end
  end
end
