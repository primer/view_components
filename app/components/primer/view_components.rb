# frozen_string_literal: true

require "active_support/core_ext"

# ViewComponent

require "view_component/engine"

# Octicons

require "octicons_helper/helper"

Primer::ViewComponents::PATHS = [
  "lib/primer/class_name_helper",
  "lib/primer/classify",
  "lib/primer/fetch_or_fallback_helper",
  "app/components/primer/component",
  "app/components/primer/base_component",
  "app/components/primer/slot",
  "app/components/primer/border_box_component",
  "app/components/primer/box_component",
  "app/components/primer/breadcrumb_component",
  "app/components/primer/button_component",
  "app/components/primer/counter_component",
  "app/components/primer/details_component",
  "app/components/primer/dropdown_menu_component",
  "app/components/primer/flex_component",
  "app/components/primer/flex_item_component",
  "app/components/primer/heading_component",
  "app/components/primer/label_component",
  "app/components/primer/layout_component",
  "app/components/primer/link_component",
  "app/components/primer/progress_bar_component",
  "app/components/primer/state_component",
  "app/components/primer/subhead_component",
  "app/components/primer/text_component",
  "app/components/primer/timeline_item_component",
  "app/components/primer/underline_nav_component"
]

unless Rails.env.development?
  PATHS.each do |path|
    require path
  end
end
