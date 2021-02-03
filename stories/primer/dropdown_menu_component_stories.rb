# frozen_string_literal: true

class Primer::DropdownMenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:with_items) do
    controls do
      select(:direction, Primer::DropdownMenuComponent::DIRECTION_OPTIONS, Primer::DropdownMenuComponent::DIRECTION_DEFAULT)
      select(:scheme, Primer::DropdownMenuComponent::SCHEME_MAPPINGS.keys, Primer::DropdownMenuComponent::SCHEME_DEFAULT)
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
      select(:direction, Primer::DropdownMenuComponent::DIRECTION_OPTIONS, Primer::DropdownMenuComponent::DIRECTION_DEFAULT)
      select(:scheme, Primer::DropdownMenuComponent::SCHEME_MAPPINGS.keys, Primer::DropdownMenuComponent::SCHEME_DEFAULT)
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
