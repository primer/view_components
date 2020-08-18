# frozen_string_literal: true

class Primer::DetailsComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:details) do
    controls do
      select(:overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys.each_with_object({}) { |k, h| h[k] = k }, :none)
      select(:button, Primer::DetailsComponent::BUTTON_OPTIONS.each_with_object({}) { |k, h| h[k] = k }, :default)
    end

    content do |component|
      component.with(:summary) { "Click me" }
      component.with(:body) { "Body" }
    end
  end
end
