# frozen_string_literal: true

class Primer::PaginationComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:pagination) do
    controls do
      page 1
      page_count 10
      show_pages true
      margin_pages 1
      surrounding_pages 2
    end
  end
end
