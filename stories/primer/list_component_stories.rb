# frozen_string_literal: true

class Primer::ListComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:list) do
    controls do
      text(:classes, "")
      unstyled false
    end

    content do |component|
      component.item { "Item 1" }
      component.item { "Item 2" }
      component.item { "Item 3" }
      component.item { "Item 4" }
    end
  end
end
