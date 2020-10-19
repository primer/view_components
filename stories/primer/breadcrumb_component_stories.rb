# frozen_string_literal: true

class Primer::BreadcrumbComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:breadcrumb) do
    content do |component|
      component.slot(:item, selected: false) { "Breadcrumb Item one" }
      component.slot(:item, href: "https://github.com/") { "Breadcrumb Item two" }
    end
  end
end
