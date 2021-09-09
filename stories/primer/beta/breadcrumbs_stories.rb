# frozen_string_literal: true

require "primer/beta/breadcrumbs"

class Primer::Beta::BreadcrumbsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:breadcrumbs) do
    content do |component|
      component.item(href: "https://github.com/") { "Breadcrumb Item one" }
      component.item(href: "/home") { "Breadcrumb Item two" }
    end
  end
end
