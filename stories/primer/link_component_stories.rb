# frozen_string_literal: true

class Primer::LinkComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    controls do
      href "https://github.com/"
      muted false
      underline true
      select(:scheme, Primer::LinkComponent::SCHEME_MAPPINGS.keys, Primer::LinkComponent::DEFAULT_SCHEME)
      select(:tag, Primer::LinkComponent::TAG_OPTIONS, Primer::LinkComponent::DEFAULT_TAG)
    end

    content do
      "This is a link!"
    end
  end

  story(:with_tooltip) do
    controls do
      href "https://github.com/"
      muted false
      underline true
      text(:id, "link-with-tooltip")
      select(:scheme, Primer::LinkComponent::SCHEME_MAPPINGS.keys, Primer::LinkComponent::DEFAULT_SCHEME)
      select(:tag, Primer::LinkComponent::TAG_OPTIONS, Primer::LinkComponent::DEFAULT_TAG)
    end

    content do |c|
      c.tooltip(text: "Tooltip text")
      "This is a link!"
    end
  end
end
