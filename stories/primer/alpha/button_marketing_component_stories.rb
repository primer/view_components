# frozen_string_literal: true

require "primer/alpha/button_marketing_component"

class Primer::Alpha::ButtonMarketingComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_marketing) do
    controls do
      select(:scheme, Primer::Alpha::ButtonMarketingComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::Alpha::ButtonMarketingComponent::VARIANT_OPTIONS, :default)
      select(:tag, Primer::Alpha::ButtonMarketingComponent::TAG_OPTIONS, :button)
      select(:type, Primer::Alpha::ButtonMarketingComponent::TYPE_OPTIONS, :button)
    end

    content do
      "Click me"
    end
  end
end
