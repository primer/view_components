# frozen_string_literal: true

require "primer/alpha/layout"

class Primer::Alpha::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    constructor(
      gutter: select(Primer::Alpha::Layout::GUTTER_OPTIONS, Primer::Alpha::Layout::GUTTER_DEFAULT),
      stacking_breakpoint: select(Primer::Alpha::Layout::STACKING_BREAKPOINT_OPTIONS, Primer::Alpha::Layout::STACKING_BREAKPOINT_DEFAULT),
      first_in_source: select(Primer::Alpha::Layout::FIRST_IN_SOURCE_OPTIONS, Primer::Alpha::Layout::FIRST_IN_SOURCE_DEFAULT),
    )

    main(border: true) do
      "Main pane"
    end
    sidebar(border: true) do
      "Sidebar pane"
    end
  end
end
