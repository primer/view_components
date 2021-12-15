# frozen_string_literal: true

require "primer/dropdown/menu"

class Primer::Dropdown::Menu::ItemStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:item) do
    constructor(
      as: select(Primer::Dropdown::Menu::AS_OPTIONS, Primer::Dropdown::Menu::AS_DEFAULT),
      tag: select(Primer::Dropdown::Menu::Item::TAG_OPTIONS, Primer::Dropdown::Menu::Item::TAG_DEFAULT),
      divider: boolean(false)
    )

    content do
      "Content"
    end
  end
end
