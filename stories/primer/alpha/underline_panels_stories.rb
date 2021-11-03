# frozen_string_literal: true

require "primer/alpha/underline_panels"

class Primer::Alpha::UnderlinePanelsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_panels) do
    controls do
      label "aria label"
      select(:align, Primer::Alpha::UnderlineNav::ALIGN_OPTIONS, :left)
    end

    content do |c|
      c.tab(selected: true, id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab(id: "tab-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      c.tab(id: "tab-3") do |t|
        t.panel { "Panel 3" }
        t.text { "Tab 3" }
      end
    end
  end
end
