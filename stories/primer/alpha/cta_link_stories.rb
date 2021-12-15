# frozen_string_literal: true

require "primer/alpha/cta_link"

class Primer::Alpha::CtaLinkStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:cta_link) do
    controls do
      href "#"
      select(:scheme, Primer::Alpha::CtaLink::SCHEME_OPTIONS, Primer::Alpha::CtaLink::DEFAULT_SCHEME)
      select(:size, Primer::Alpha::CtaLink::SIZE_OPTIONS, :medium)
      block false
    end

    content do
      "Click me"
    end
  end
end
