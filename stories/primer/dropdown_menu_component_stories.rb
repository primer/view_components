# frozen_string_literal: true

class Primer::DropdownMenuComponentStories < ViewComponent::Storybook::Stories
  title "Primer/Deprecated/DropdownMenu"

  layout "storybook_centered_preview"

  story(:with_header) do
    constructor(
      direction: select(Primer::DropdownMenuComponent::DIRECTION_OPTIONS, Primer::DropdownMenuComponent::DIRECTION_DEFAULT),
      scheme: select(Primer::DropdownMenuComponent::SCHEME_MAPPINGS.keys, Primer::DropdownMenuComponent::SCHEME_DEFAULT),
      header: text("Header")
    )

    content do
      "<ul><li><a class='dropdown-item'>Turkey sandwich</a></li></ul>".html_safe
    end
  end
end
