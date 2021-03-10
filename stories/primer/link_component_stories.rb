# frozen_string_literal: true

class Primer::LinkComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    controls do
      href "https://github.com/"
      muted false
      underline true
      select(:variant, Primer::LinkComponent::VARIANT_MAPPINGS.keys, Primer::LinkComponent::DEFAULT_VARIANT)
      select(:tag, Primer::LinkComponent::TAG_OPTIONS, Primer::LinkComponent::DEFAULT_TAG)
    end

    content do
      "This is a link!"
    end
  end
end
