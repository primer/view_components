# frozen_string_literal: true

class Primer::TabNavContainerComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_nav_container) do
    content do |c|
      c.nav(with_panel: true) do |n|
        n.tab(selected: true, title: "Tab 1") { "Panel 1" }
        n.tab(title: "Tab 2") { "Panel 2" }
        n.tab(title: "Tab 3") { "Panel 3" }
      end
    end
  end
end
