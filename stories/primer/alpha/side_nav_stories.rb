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
      c.item(href: "#url", selected: true) do |i|
        i.trailing_visual(icon: :"dot-fill")
        "With status icon"
      end
      c.item(href: "#url") do |i|
        i.trailing_visual(count: 10)
        "With counter"
      end
      c.item(href: "#url") do |i|
        i.trailing_visual(label: "Label")
        "With label"
      end
      c.item(href: "#url") do |i|
        i.leading_visual(icon: :"mark-github")
        i.trailing_visual(label: "Label")
        "With icon and label"
      end
    end
  end
end
