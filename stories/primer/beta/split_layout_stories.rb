# frozen_string_literal: true

require "primer/beta/split_layout"

class Primer::Beta::SplitLayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:page_layout) do
    controls do
      select(:wrapper_sizing, Primer::Beta::BaseLayout::WRAPPER_SIZING_OPTIONS, Primer::Beta::BaseLayout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::BaseLayout::OUTER_SPACING_OPTIONS, Primer::Beta::BaseLayout::OUTER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::BaseLayout::COLUMN_GAP_OPTIONS, Primer::Beta::BaseLayout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::BaseLayout::ROW_GAP_OPTIONS, Primer::Beta::BaseLayout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::BaseLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::BaseLayout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::BaseLayout::RESPONSIVE_VARIANT_DEFAULT)
      responsive_show_pane_first false
      select(:multi_columns_variant_at, Primer::Beta::BaseLayout::MULTI_COLUMNS_VARIANT_AT_OPTIONS, Primer::Beta::BaseLayout::MULTI_COLUMNS_VARIANT_AT_DEFAULT)
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
      select(:wrapper_sizing, Primer::Beta::BaseLayout::WRAPPER_SIZING_OPTIONS, Primer::Beta::BaseLayout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::BaseLayout::OUTER_SPACING_OPTIONS, Primer::Beta::BaseLayout::OUTER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::BaseLayout::COLUMN_GAP_OPTIONS, Primer::Beta::BaseLayout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::BaseLayout::ROW_GAP_OPTIONS, Primer::Beta::BaseLayout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::BaseLayout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::BaseLayout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::BaseLayout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::BaseLayout::RESPONSIVE_VARIANT_DEFAULT)
      responsive_show_pane_first false
      select(:multi_columns_variant_at, Primer::Beta::BaseLayout::MULTI_COLUMNS_VARIANT_AT_OPTIONS, Primer::Beta::BaseLayout::MULTI_COLUMNS_VARIANT_AT_DEFAULT)
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
