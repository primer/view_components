# frozen_string_literal: true

class Primer::SelectMenuIconComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:select_menu_icon) do
    controls do
      text(:icon, "check")
      select(:size, Primer::SelectMenuIconComponent::SIZE_MAPPINGS.keys, :small)
    end
  end
end
