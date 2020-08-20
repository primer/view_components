# frozen_string_literal: true

class Primer::DetailsComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:details) do
    controls do
      select(:overlay, Primer::StoriesHelper.array_to_options(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys), :none)
      select(:button, Primer::StoriesHelper.array_to_options(Primer::DetailsComponent::BUTTON_OPTIONS), :default)
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.with(:body) { "Body" }
    end
  end
end
