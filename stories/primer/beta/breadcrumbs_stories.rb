# frozen_string_literal: true

require "primer/beta/breadcrumbs"

class Primer::Beta::BreadcrumbsStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:breadcrumbs) do
    item(href: "https://github.com/") { "Breadcrumb Item one" }
    item(href: "/home") { "Breadcrumb Item two" }
  end
end
