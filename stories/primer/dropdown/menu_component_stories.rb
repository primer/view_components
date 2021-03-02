# frozen_string_literal: true

require "primer/dropdown/menu_component"

class Primer::Dropdown::MenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  self.title = "Primer/Dropdown Component/Menu"

  story(:with_items) do
    controls do
      select(:direction, Primer::Dropdown::MenuComponent::DIRECTION_OPTIONS, Primer::Dropdown::MenuComponent::DIRECTION_DEFAULT)
      select(:scheme, Primer::Dropdown::MenuComponent::SCHEME_MAPPINGS.keys, Primer::Dropdown::MenuComponent::SCHEME_DEFAULT)
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
      select(:direction, Primer::Dropdown::MenuComponent::DIRECTION_OPTIONS, Primer::Dropdown::MenuComponent::DIRECTION_DEFAULT)
      select(:scheme, Primer::Dropdown::MenuComponent::SCHEME_MAPPINGS.keys, Primer::Dropdown::MenuComponent::SCHEME_DEFAULT)
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
