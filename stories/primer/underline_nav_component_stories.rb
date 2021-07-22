# frozen_string_literal: true

class Primer::UnderlineNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_nav) do
    controls do
      label "aria label"
      select(:align, Primer::UnderlineNavComponent::ALIGN_OPTIONS, :left)
      with_panel false
      body_arguments(tag: :ul)
    end

    content do |c|
      c.tab(selected: true, id: "tab-1") do |t|
        t.panel { "Panel 1" }
        t.text { "Tab 1" }
      end
      c.tab(id: "tab-2") do |t|
        t.panel { "Panel 2" }
        t.text { "Tab 2" }
      end
      c.tab(id: "tab-3") do |t|
        t.panel { "Panel 3" }
        t.text { "Tab 3" }
      end
    end
  end
end
