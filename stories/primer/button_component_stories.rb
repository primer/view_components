# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, :button)
      group_item false
    end
    content do
      "Click me"
    end
  end
end
