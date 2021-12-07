# frozen_string_literal: true

require "primer/beta/split_layout"

class Primer::Beta::SplitLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      select(:inner_spacing, Primer::Beta::SplitLayout::INNER_SPACING_OPTIONS, Primer::Beta::SplitLayout::INNER_SPACING_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::SplitLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::SplitLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
    end

    content do |c|
      c.main(border: true) do
        "Main region"
      end
      c.pane(border: true) do
        "Sidebar region"
      end
    end
  end
end
