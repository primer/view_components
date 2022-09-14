# frozen_string_literal: true

require "primer/dropdown/menu"

class Primer::Dropdown::MenuStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:with_items) do
    controls do
      select(:as, Primer::Dropdown::Menu::AS_OPTIONS, Primer::Dropdown::Menu::AS_DEFAULT)
      select(:direction, Primer::Dropdown::Menu::DIRECTION_OPTIONS, Primer::Dropdown::Menu::DIRECTION_DEFAULT)
      select(:scheme, Primer::Dropdown::Menu::SCHEME_MAPPINGS.keys, Primer::Dropdown::Menu::SCHEME_DEFAULT)
      header "Header"
    end

    content do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
      c.item { "Item 3" }
      c.item { "Item 4" }
    end
  end

  story(:with_divider) do
    controls do
      select(:as, Primer::Dropdown::Menu::AS_OPTIONS, Primer::Dropdown::Menu::AS_DEFAULT)
      select(:direction, Primer::Dropdown::Menu::DIRECTION_OPTIONS, Primer::Dropdown::Menu::DIRECTION_DEFAULT)
      select(:scheme, Primer::Dropdown::Menu::SCHEME_MAPPINGS.keys, Primer::Dropdown::Menu::SCHEME_DEFAULT)
      header "Header"
    end

    content do |c|
      c.item { "Item 1" }
      c.item { "Item 2" }
      c.item(divider: true)
      c.item { "Item 3" }
      c.item { "Item 4" }
    end
  end
end
