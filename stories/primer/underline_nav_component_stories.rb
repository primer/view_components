# frozen_string_literal: true

class Primer::UnderlineNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_nav) do
    controls do
      select(:align, Primer::UnderlineNavComponent::ALIGN_OPTIONS, :left)
      with_panel false
    end

    content do |c|
      c.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        t.title { "Tab 1" }
      end
      c.tab do |t|
        t.panel { "Panel 2" }
        t.title { "Tab 2" }
      end
      c.tab do |t|
        t.panel { "Panel 3" }
        t.title { "Tab 3" }
      end
    end
  end
end
