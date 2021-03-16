# frozen_string_literal: true

class Primer::ButtonOutlineComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  self.title = "Primer/Button Component"

  story(:outline) do
    controls do
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
