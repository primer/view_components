# frozen_string_literal: true

class Primer::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      divider false
      select(:container, Primer::Layout::CONTAINER_OPTIONS, Primer::Layout::CONTAINER_DEFAULT)
      select(:gutter, Primer::Layout::GUTTER_OPTIONS, Primer::Layout::GUTTER_DEFAULT)
      select(:flow_row_until, Primer::Layout::FLOW_ROW_UNTIL_OPTIONS, Primer::Layout::FLOW_ROW_UNTIL_DEFAULT)
      select(:sidebar_width, Primer::Layout::SIDEBAR_WIDTH_OPTIONS, Primer::Layout::SIDEBAR_WIDTH_DEFAULT)
      select(:sidebar_placement, Primer::Layout::SIDEBAR_PLACEMENT_OPTIONS, Primer::Layout::SIDEBAR_PLACEMENT_DEFAULT)
    end

    content do |c|
      c.main { "Main" }
      c.sidebar { "Sidebar" }
    end
  end
end
