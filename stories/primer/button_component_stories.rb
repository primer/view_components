# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:button_type, Primer::ButtonComponent::BUTTON_TYPE_OPTIONS.each_with_object({}) { |k, h| h[k] = k }, :primary)
    end
    content do
      "Click me"
    end
  end
end
