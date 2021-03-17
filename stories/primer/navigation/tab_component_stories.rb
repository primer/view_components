# frozen_string_literal: true

class Primer::Navigation::TabComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:tab) do
    controls do
      selected true
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do
      "Tab"
    end
  end
end
