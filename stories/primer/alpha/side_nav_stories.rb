# frozen_string_literal: true

require "primer/alpha/side_nav"

class Primer::Alpha::SideNavStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:side_nav) do
    controls do
      bordered true
      classes "custom-class"
    end

    content do |c|
      c.item(href: "#url") do |i|
        i.leading_visual(src: "https://github.com/github.png", alt: "@github")
        "With avatar"
      end
      c.item(href: "#url") do |i|
        i.leading_visual(icon: :"mark-github")
        "With icon"
      end
      c.item(href: "#url", selected: true) { "Item 3" }
      c.item(href: "#url") { "Item 4" }
      c.item(href: "#url") { "Item 5" }
    end
  end
end
