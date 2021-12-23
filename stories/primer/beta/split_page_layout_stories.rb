# frozen_string_literal: true

require "primer/beta/split_page_layout"

class Primer::Beta::SplitPageLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      select(:inner_spacing, Primer::Beta::SplitPageLayout::INNER_SPACING_OPTIONS, Primer::Beta::SplitPageLayout::INNER_SPACING_DEFAULT)
      select(:primary_region, Primer::Beta::SplitPageLayout::PRIMARY_REGION_OPTIONS, Primer::Beta::SplitPageLayout::PRIMARY_REGION_DEFAULT)
    end

    content do |c|
      c.content_region(border: true) do
        "Content region"
      end
      c.pane_region(border: true) do
        "Pane region"
      end
    end
  end
end
