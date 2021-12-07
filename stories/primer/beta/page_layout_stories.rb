# frozen_string_literal: true

require "primer/beta/page_layout"

class Primer::Beta::PageLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      select(:wrapper_sizing, Primer::Beta::PageLayout::WRAPPER_SIZING_OPTIONS, Primer::Beta::PageLayout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::PageLayout::OUTER_SPACING_OPTIONS, Primer::Beta::PageLayout::OUTER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::PageLayout::COLUMN_GAP_OPTIONS, Primer::Beta::PageLayout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::PageLayout::ROW_GAP_OPTIONS, Primer::Beta::PageLayout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::PageLayout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::PageLayout::RESPONSIVE_VARIANT_DEFAULT)
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

  story(:page_layout_with_header_and_footer) do
    controls do
      select(:wrapper_sizing, Primer::Beta::PageLayout::WRAPPER_SIZING_OPTIONS, Primer::Beta::PageLayout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::PageLayout::OUTER_SPACING_OPTIONS, Primer::Beta::PageLayout::OUTER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::PageLayout::COLUMN_GAP_OPTIONS, Primer::Beta::PageLayout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::PageLayout::ROW_GAP_OPTIONS, Primer::Beta::PageLayout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::PageLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::PageLayout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::PageLayout::RESPONSIVE_VARIANT_DEFAULT)
    end

    content do |c|
      c.header(border: true) do
        "Header region"
      end
      c.main(border: true) do
        "Main region"
      end
      c.pane(border: true) do
        "Pane region"
      end
      c.footer(border: true) do
        "Footer region"
      end
    end
  end
end
