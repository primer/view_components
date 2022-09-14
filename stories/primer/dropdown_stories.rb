# frozen_string_literal: true

class Primer::DropdownStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:dropdown) do
    controls do
      select(:overlay, Primer::Beta::Details::OVERLAY_MAPPINGS.keys, :default)
      with_caret false
    end

    content do |c|
      c.button { "Dropdown" }
      c.menu(header: "Header") do |m|
        m.item { "Item 1" }
        m.item { "Item 2" }
        m.item(divider: true)
        m.item { "Item 3" }
        m.item { "Item 4" }
      end
    end
  end
end
