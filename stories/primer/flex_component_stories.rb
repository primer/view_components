# frozen_string_literal: true

class Primer::FlexComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:default) do
    controls do
      select(:justify_content, Primer::FlexComponent::JUSTIFY_CONTENT_OPTIONS, :center)
      select(:align_items, Primer::FlexComponent::ALIGN_ITEMS_OPTIONS, :start)
      select(:direction, Primer::FlexComponent::ALLOWED_DIRECTIONS, :row)
      inline false
      flex_wrap false
    end

    content do
      "<div>Foo</div><div>Bar</div><div>Baz</div>".html_safe
    end
  end
end
