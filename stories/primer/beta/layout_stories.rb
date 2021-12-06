# frozen_string_literal: true

require "primer/beta/layout"

class Primer::Beta::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      select(:wrapper_sizing, Primer::Beta::Layout::WRAPPER_SIZING_OPTIONS, Primer::Beta::Layout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::Layout::OUTER_SPACING_OPTIONS, Primer::Beta::Layout::OUTER_SPACING_DEFAULT)
      select(:inner_spacing, Primer::Beta::Layout::INNER_SPACING_OPTIONS, Primer::Beta::Layout::INNER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::Layout::COLUMN_GAP_OPTIONS, Primer::Beta::Layout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::Layout::ROW_GAP_OPTIONS, Primer::Beta::Layout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::Layout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::Layout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::Layout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::Layout::RESPONSIVE_VARIANT_DEFAULT)
      responsive_show_pane_first false
      select(:multi_columns_variant_at, Primer::Beta::Layout::MULTI_COLUMNS_VARIANT_AT_OPTIONS, Primer::Beta::Layout::MULTI_COLUMNS_VARIANT_AT_DEFAULT)
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

  story(:layout_with_header_and_footer) do
    controls do
      select(:wrapper_sizing, Primer::Beta::Layout::WRAPPER_SIZING_OPTIONS, Primer::Beta::Layout::WRAPPER_SIZING_DEFAULT)
      select(:outer_spacing, Primer::Beta::Layout::OUTER_SPACING_OPTIONS, Primer::Beta::Layout::OUTER_SPACING_DEFAULT)
      select(:inner_spacing, Primer::Beta::Layout::INNER_SPACING_OPTIONS, Primer::Beta::Layout::INNER_SPACING_DEFAULT)
      select(:column_gap, Primer::Beta::Layout::COLUMN_GAP_OPTIONS, Primer::Beta::Layout::COLUMN_GAP_DEFAULT)
      select(:row_gap, Primer::Beta::Layout::ROW_GAP_OPTIONS, Primer::Beta::Layout::ROW_GAP_DEFAULT)
      select(:responsive_primary_region, Primer::Beta::Layout::RESPONSIVE_PRIMARY_REGION_OPTIONS, Primer::Beta::Layout::RESPONSIVE_PRIMARY_REGION_DEFAULT)
      select(:responsive_variant, Primer::Beta::Layout::RESPONSIVE_VARIANT_OPTIONS, Primer::Beta::Layout::RESPONSIVE_VARIANT_DEFAULT)
      responsive_show_pane_first false
      select(:multi_columns_variant_at, Primer::Beta::Layout::MULTI_COLUMNS_VARIANT_AT_OPTIONS, Primer::Beta::Layout::MULTI_COLUMNS_VARIANT_AT_DEFAULT)
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
