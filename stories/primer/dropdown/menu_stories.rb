# frozen_string_literal: true

require "primer/dropdown/menu"

class Primer::Dropdown::MenuStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:with_items) do
    constructor(
      as: select(Primer::Dropdown::Menu::AS_OPTIONS, Primer::Dropdown::Menu::AS_DEFAULT),
      direction: select(Primer::Dropdown::Menu::DIRECTION_OPTIONS, Primer::Dropdown::Menu::DIRECTION_DEFAULT),
      scheme: select(Primer::Dropdown::Menu::SCHEME_MAPPINGS.keys, Primer::Dropdown::Menu::SCHEME_DEFAULT),
      header: "Header"
    )

    item { "Item 1" }
    item { "Item 2" }
    item { "Item 3" }
    item { "Item 4" }
  end

  story(:with_divider) do
    constructor(
      as: select(Primer::Dropdown::Menu::AS_OPTIONS, Primer::Dropdown::Menu::AS_DEFAULT),
      direction: select(Primer::Dropdown::Menu::DIRECTION_OPTIONS, Primer::Dropdown::Menu::DIRECTION_DEFAULT),
      scheme: select(Primer::Dropdown::Menu::SCHEME_MAPPINGS.keys, Primer::Dropdown::Menu::SCHEME_DEFAULT),
      header: "Header"
    )

    item { "Item 1" }
    item { "Item 2" }
    item(divider: true)
    item { "Item 3" }
    item { "Item 4" }
  end
end
