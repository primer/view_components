# frozen_string_literal: true

class Primer::MenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:menu) do
    item(selected: true, href: "#url") { "Item 1" }
    item(href: "#url") { "Item 2" }
    item(href: "#url") { "Item 3" }
  end

  story(:with_heading) do
    heading(tag: :div) { "Heading" }
    item(selected: true, href: "#url") { "Item 1" }
    item(href: "#url") { "Item 2" }
    item(href: "#url") { "Item 3" }
  end
end
