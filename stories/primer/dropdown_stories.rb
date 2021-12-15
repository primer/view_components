# frozen_string_literal: true

class Primer::DropdownStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:dropdown) do
    constructor(
      overlay: select(Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :default),
      with_caret: boolean(false)
    )

    button { "Dropdown" }
    menu(header: "Headers") do |m|
      m.item { "item 1" }
      m.item { "item 2" }
      m.item(divider: true)
      m.item { "Item 3" }
      m.item { "Item 4" }
    end
  end
end
