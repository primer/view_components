# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:button_type, Primer::ButtonComponent::BUTTON_TYPE_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::ButtonComponent::TAG_OPTIONS, :button)
      select(:type, Primer::ButtonComponent::TYPE_OPTIONS, :button)
      group_item false
    end
    content do
      "Click me"
    end
  end
end
