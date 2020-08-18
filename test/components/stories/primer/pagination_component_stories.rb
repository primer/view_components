# frozen_string_literal: true

class Primer::PaginationComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:pagination) do
    controls do
      current_page 3
      page_count 5
      show_pages true
      margin_page_count 1
      surrounding_page_count 1
    end
  end
end
