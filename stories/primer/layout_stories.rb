# frozen_string_literal: true

class Primer::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      select(:container, Primer::Layout::CONTAINER_OPTIONS, Primer::Layout::CONTAINER_DEFAULT)
      select(:sidebar_width, Primer::Layout::SIDEBAR_WIDTH_OPTIONS, Primer::Layout::SIDEBAR_WIDTH_DEFAULT)
      select(:gutter, Primer::Layout::GUTTER_OPTIONS, Primer::Layout::GUTTER_DEFAULT)
    end

    content do
      "Update your stories!"
    end
  end
end
