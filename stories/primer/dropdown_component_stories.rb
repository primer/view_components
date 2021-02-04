# frozen_string_literal: true

class Primer::DropdownComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:dropdown) do
    controls do
      select(:overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :default)
      reset true
      summary_classes "some-class"
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
