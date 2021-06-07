# frozen_string_literal: true

require "primer/alpha/button_marketing"

class Primer::Alpha::ButtonMarketingStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_marketing) do
    controls do
      select(:scheme, Primer::Alpha::ButtonMarketing::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::Alpha::ButtonMarketing::VARIANT_OPTIONS, :default)
      select(:tag, Primer::Alpha::ButtonMarketing::TAG_OPTIONS, :button)
      select(:type, Primer::Alpha::ButtonMarketing::TYPE_OPTIONS, :button)
    end

    content do
      "Click me"
    end
  end
end
