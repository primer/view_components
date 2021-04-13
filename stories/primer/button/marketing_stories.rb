# frozen_string_literal: true

require "primer/button/base"
require "primer/button/marketing"

class Primer::Button::MarketingStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:marketing) do
    controls do
      select(:scheme, Primer::Button::Marketing::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::Button::Marketing::VARIANT_OPTIONS, :default)
      select(:tag, Primer::Button::Marketing::TAG_OPTIONS, :button)
      select(:type, Primer::Button::Marketing::TYPE_OPTIONS, :button)
    end

    content do
      "Click me"
    end
  end
end
