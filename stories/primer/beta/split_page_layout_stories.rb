# frozen_string_literal: true

require "primer/beta/split_page_layout"

class Primer::Beta::SplitPageLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      select(:inner_spacing, Primer::Beta::SplitPageLayout::INNER_SPACING_OPTIONS, Primer::Beta::SplitPageLayout::INNER_SPACING_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::SplitPageLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::SplitPageLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
    end

    content do |c|
      c.main(border: true) do
        "Main region"
      end
      c.pane(border: true) do
        "Pane region"
      end
    end
  end
end
