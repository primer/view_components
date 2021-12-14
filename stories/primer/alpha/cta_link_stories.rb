# frozen_string_literal: true

require "primer/alpha/cta_link"

class Primer::Alpha::CtaLinkStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:cta_link) do
    controls do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
