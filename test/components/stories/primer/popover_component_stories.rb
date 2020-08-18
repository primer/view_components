# frozen_string_literal: true

class Primer::PopoverComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:popover) do
    controls do
      condensed false
    end

    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message) { "Message about this particular piece of UI." }
      component.slot(:button) { "Got it!" }
    end
  end
end
