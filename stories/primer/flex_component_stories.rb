# frozen_string_literal: true

class Primer::FlexComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:default) do
    constructor(
      justify_content: select(Primer::FlexComponent::JUSTIFY_CONTENT_OPTIONS.compact, :center),
      align_items: select(Primer::FlexComponent::ALIGN_ITEMS_OPTIONS.compact, :start),
      direction: select(Primer::FlexComponent::ALLOWED_DIRECTIONS.compact, :row),
      inline: boolean(false),
      flex_wrap: boolean(false)
    )

    content do
      "<div class='p-5 border bg-gray-light'>Item 1</div>
      <div class='p-5 border bg-gray-light'>Item 2</div>
      <div class='p-5 border bg-gray-light'>Item 3</div>".html_safe
    end
  end
end
