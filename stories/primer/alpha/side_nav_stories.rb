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
        i.leading_visual(Primer::Beta::Avatar.new(src: "https://github.com/github.png", alt: "@github"))
        "With avatar"
      end
      c.item(href: "#url") do |i|
        i.leading_visual(Primer::OcticonComponent.new(icon: :"mark-github"))
        "With icon"
      end
      c.item(href: "#url", selected: true) do |i|
        i.trailing_visual("Octicon", icon: :"dot-fill")
        "With status icon"
      end
      c.item(href: "#url") do |i|
        i.trailing_visual("Counter", count: 10)
        "With counter"
      end
      c.item(href: "#url") do |i|
        i.trailing_visual("Label") do
          "Label"
        end
        "With label"
      end
      c.item(href: "#url") do |i|
        i.leading_visual(Primer::OcticonComponent.new(icon: :"mark-github"))
        i.trailing_visual("Label") do
          "Label"
        end
        "With icon and label"
      end
    end
  end
end
