# frozen_string_literal: true

require "primer/alpha/tab_panels"

class Primer::Alpha::TabPanelsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_panels) do
    controls do
      label "Repository"
    end

    content do |c|
      c.tab(href: "#", selected: true, id: "tab-1") do |t|
        t.text { "Tab 1" }
        t.panel { "Panel 1" }
      end
      c.tab(href: "#", id: "tab-2") do |t|
        t.text { "Tab 2" }
        t.panel { "Panel 2" }
      end
      c.tab(href: "#", id: "tab-3") do |t|
        t.text { "Tab 3" }
        t.panel { "Panel 3" }
      end
      c.extra do
        "<button class=\"btn btn-sm float-right\">Button</button>".html_safe
      end
    end
  end
end
