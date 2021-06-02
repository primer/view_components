# frozen_string_literal: true

class Primer::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      select(:density, Primer::Layout::DENSITY_OPTIONS, Primer::Layout::DENSITY_DEFAULT)
      select(:container, Primer::Layout::CONTAINER_OPTIONS, Primer::Layout::CONTAINER_DEFAULT)
      select(:gutter, Primer::Layout::GUTTER_OPTIONS, Primer::Layout::GUTTER_DEFAULT)
      select(:flow_row_until, Primer::Layout::FLOW_ROW_UNTIL_OPTIONS, Primer::Layout::FLOW_ROW_UNTIL_DEFAULT)
      select(:sidebar_width, Primer::Layout::SIDEBAR_WIDTH_OPTIONS, Primer::Layout::SIDEBAR_WIDTH_DEFAULT)
      select(:sidebar_placement, Primer::Layout::SIDEBAR_PLACEMENT_OPTIONS, Primer::Layout::SIDEBAR_PLACEMENT_DEFAULT)
      select(:sidebar_flow_row_placement, Primer::Layout::SIDEBAR_FLOW_ROW_PLACEMENT_OPTIONS, Primer::Layout::SIDEBAR_FLOW_ROW_PLACEMENT_DEFAULT)
      select(:main_width, Primer::Layout::MAIN_WIDTH_OPTIONS, Primer::Layout::MAIN_WIDTH_DEFAULT)
      with_divider false
      select(:divider_flow_row_variant, Primer::Layout::DIVIDER_FLOW_ROW_VARIANT_OPTIONS, Primer::Layout::DIVIDER_FLOW_ROW_VARIANT_DEFAULT)
    end

    content do |c|
      c.main(border: true) { "Main" }
      c.sidebar(border: true) { "Sidebar" }
    end
  end
end
