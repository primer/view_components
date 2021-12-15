# frozen_string_literal: true

require "primer/alpha/tab_nav"

class Primer::Alpha::TabNavStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_nav) do
    constructor(label: "Repository")

    tab(href: "#", selected: true, id: "tab-1") do |_t|
      "Tab 1"
    end
    tab(href: "#", id: "tab-2") do |_t|
      "Tab 2"
    end
    tab(href: "#", id: "tab-3") do |_t|
      "Tab 3"
    end
    extra do
      "<button class=\"btn btn-sm float-right\">Button</button>".html_safe
    end
  end
end
