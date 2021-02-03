# frozen_string_literal: true

class Primer::ButtonMarketingComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_marketing) do
    controls do
      select(:button_type, Primer::ButtonMarketingComponent::BUTTON_TYPE_OPTIONS, :primary)
      select(:variant, Primer::ButtonMarketingComponent::VARIANT_OPTIONS, :default)
      select(:tag, Primer::ButtonMarketingComponent::TAG_OPTIONS, :button)
      select(:type, Primer::ButtonMarketingComponent::TYPE_OPTIONS, :button)
    end

    content do
      "Click me"
    end
  end
end
