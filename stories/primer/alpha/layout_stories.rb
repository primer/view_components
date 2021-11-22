# frozen_string_literal: true

require "primer/alpha/layout"

class Primer::Alpha::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      select(:gutter, Primer::Alpha::Layout::GUTTER_OPTIONS, Primer::Alpha::Layout::GUTTER_DEFAULT)
      select(:stacking_breakpoint, Primer::Alpha::Layout::STACKING_BREAKPOINT_OPTIONS, Primer::Alpha::Layout::STACKING_BREAKPOINT_DEFAULT)
      select(:first_in_source, Primer::Alpha::Layout::FIRST_IN_SOURCE_OPTIONS, Primer::Alpha::Layout::FIRST_IN_SOURCE_DEFAULT)
    end

    content do |c|
      c.main(border: true) do
        "Main pane"
      end
      c.sidebar(border: true) do
        "Sidebar pane"
      end
    end
  end
end
