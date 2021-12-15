# frozen_string_literal: true

require "primer/alpha/underline_nav"

class Primer::Alpha::UnderlineNavStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_nav) do
    constructor(
      label: "aria label",
      align: select(Primer::Alpha::UnderlineNav::ALIGN_OPTIONS, :left)
    )

    tab(href: "#", selected: true, id: "tab-1") do |t|
      t.text { "Tab 1" }
    end
    tab(href: "#", id: "tab-2") do |t|
      t.text { "Tab 2" }
    end
    tab(href: "#", id: "tab-3") do |t|
      t.text { "Tab 3" }
    end
  end
end
