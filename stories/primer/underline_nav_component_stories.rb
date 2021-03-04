# frozen_string_literal: true

class Primer::UnderlineNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_nav) do
    controls do
      select(:align, Primer::UnderlineNavComponent::ALIGN_OPTIONS, :left)
    end

    content do |component|
      component.body { "body" }
    end
  end
end
