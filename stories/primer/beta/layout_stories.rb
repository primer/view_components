# frozen_string_literal: true

require "primer/beta/layout"

class Primer::Beta::LayoutStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      select(:wrapper_sizing, Primer::Beta::Layout::WRAPPER_SIZING_OPTIONS, Primer::Beta::Layout::WRAPPER_SIZING_DEFAULT)
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
