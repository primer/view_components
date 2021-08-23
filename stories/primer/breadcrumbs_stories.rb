# frozen_string_literal: true

class Primer::Beta::BreadcrumbsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:breadcrumb) do
    content do |component|
      component.item(selected: false) { "Breadcrumb Item one" }
      component.item(href: "https://github.com/") { "Breadcrumb Item two" }
    end
  end
end
