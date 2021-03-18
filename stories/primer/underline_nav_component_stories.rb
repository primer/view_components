# frozen_string_literal: true

class Primer::UnderlineNavComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:underline_nav) do
    controls do
      select(:align, Primer::UnderlineNavComponent::ALIGN_OPTIONS, :left)
      with_panel false
    end

    content do |component|
      component.tab(selected: true) do |t|
        t.panel { "Panel 1" }
        "Tab 1"
      end
      component.tab do |t|
        t.panel { "Panel 2" }
        "Tab 2"
      end
    end
  end
end
