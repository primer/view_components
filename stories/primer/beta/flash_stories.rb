# frozen_string_literal: true

class Primer::Beta::FlashStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:flash) do
    controls do
      text(:icon, "people")
      select(:scheme, Primer::Beta::Flash::SCHEME_MAPPINGS.keys, :default)
      full false
      spacious false
      dismissible false
    end

    content do
      "This is a flash message!"
    end
  end
end
