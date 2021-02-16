# frozen_string_literal: true

class Primer::DropdownMenuComponentStories < ViewComponent::Storybook::Stories
  self.title = "Primer/Deprecated/DropdownMenu"

  layout "storybook_centered_preview"

  story(:with_header) do
    controls do
      select(:direction, Primer::DropdownMenuComponent::DIRECTION_OPTIONS, Primer::DropdownMenuComponent::DIRECTION_DEFAULT)
      select(:scheme, Primer::DropdownMenuComponent::SCHEME_MAPPINGS.keys, Primer::DropdownMenuComponent::SCHEME_DEFAULT)
      header "Header"
    end

    content do |_component|
      "<ul><li><a class='dropdown-item'>Turkey sandwich</a></li></ul>".html_safe
    end
  end
end
