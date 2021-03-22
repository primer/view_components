# frozen_string_literal: true

class Primer::TabNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_nav) do
    controls do
      with_panel true
    end

    content do |c|
      c.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      c.tab do |t|
        t.panel { "Panel 3" }
        t.text { "Tab 3" }
      end
    end
  end
end
