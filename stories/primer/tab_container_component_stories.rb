# frozen_string_literal: true

class Primer::TabContainerComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tab_container) do
    content do
      <<~HTML.html_safe
        <div role="tablist">
          <button type="button" role="tab" aria-selected="true">Tab one</button>
          <button type="button" role="tab" tabindex="-1">Tab two</button>
          <button type="button" role="tab" tabindex="-1">Tab three</button>
        </div>
        <div role="tabpanel">
          Panel 1
        </div>
        <div role="tabpanel" hidden>
          Panel 2
        </div>
        <div role="tabpanel" hidden>
          Panel 3
        </div>
      HTML
    end
  end
end
