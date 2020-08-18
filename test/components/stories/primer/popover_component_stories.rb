# frozen_string_literal: true

class Primer::PopoverComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:popover) do
    controls do
      select(:caret,
        Primer::PopoverComponent::Message::CARET_MAPPINGS.each_with_object({}) { |k, h| h[k] = k },
        :primary)
    end

    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message) { "Message about this particular piece of UI." }
      component.slot(:button) { "Got it!" }
    end
  end
end
