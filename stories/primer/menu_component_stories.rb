# frozen_string_literal: true

class Primer::MenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:menu) do
    content do |c|
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
      c.item(href: "#url") { "Item 3" }
    end
  end

  story(:with_heading) do
    content do |c|
      c.heading(tag: :h2) { "Heading" }
      c.item(selected: true, href: "#url") { "Item 1" }
      c.item(href: "#url") { "Item 2" }
      c.item(href: "#url") { "Item 3" }
    end
  end
end
