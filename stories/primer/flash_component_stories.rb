# frozen_string_literal: true

class Primer::FlashComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:flash) do
    controls do
      text(:icon, "people")
      select(:variant, Primer::StoriesHelper.array_to_options(Primer::FlashComponent::VARIANT_MAPPINGS.keys), :default)
      full false
      spacious false
      dismissible false
    end

    content do
      "This is a flash message!"
    end
  end
end