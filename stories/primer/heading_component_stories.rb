# frozen_string_literal: true

class Primer::HeadingComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:heading) do
    controls do
      select(:tag, Primer::HeadingComponent::TAG_OPTIONS, Primer::HeadingComponent::TAG_FALLBACK)
    end

    content do
      "This is a heading!"
    end
  end
end
