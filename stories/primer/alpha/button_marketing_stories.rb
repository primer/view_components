# frozen_string_literal: true

require "primer/alpha/button_marketing"

class Primer::Alpha::ButtonMarketingStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_marketing) do
    constructor(
      scheme: select(Primer::Alpha::ButtonMarketing::SCHEME_OPTIONS, :primary),
      variant: select(Primer::Alpha::ButtonMarketing::VARIANT_OPTIONS, :default),
      tag: select(Primer::Alpha::ButtonMarketing::TAG_OPTIONS, :button),
      type: select(Primer::Alpha::ButtonMarketing::TYPE_OPTIONS, :button)
    )

    content do
      "Click me"
    end
  end
end
