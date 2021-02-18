# frozen_string_literal: true

class Primer::FlexComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:default) do
    controls do
      select(:justify_content, Primer::FlexComponent::JUSTIFY_CONTENT_OPTIONS.compact, :center)
      select(:align_items, Primer::FlexComponent::ALIGN_ITEMS_OPTIONS.compact, :start)
      select(:direction, Primer::FlexComponent::ALLOWED_DIRECTIONS.compact, :row)
      inline false
      flex_wrap false
    end

    content do
      "<div class='p-5 border bg-gray-light'>Item 1</div>
      <div class='p-5 border bg-gray-light'>Item 2</div>
      <div class='p-5 border bg-gray-light'>Item 3</div>".html_safe
    end
  end
end
