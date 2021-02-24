# frozen_string_literal: true

class Primer::TabNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_nav) do
    controls do
      with_panel true
    end

    content do |c|
      c.tab(selected: true, title: "Tab 1") { "Panel 1" }
      c.tab(title: "Tab 2") { "Panel 2" }
      c.tab(title: "Tab 3") { "Panel 3" }
    end
  end
end
