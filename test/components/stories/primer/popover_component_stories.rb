# frozen_string_literal: true

class Primer::PopoverComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message) { "Message about this particular piece of UI." }
      component.slot(:button) { "Got it!" }
    end
  end

  story(:large_popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message, large: true) { "Message about this particular piece of UI." }
      component.slot(:button) { "Got it!" }
    end
  end

  Primer::PopoverComponent::Message::CARET_MAPPINGS.keys.each do |caret|
    story("popover_#{caret}".to_sym) do
      content do |component|
        component.slot(:heading) { "Popover heading" }
        component.slot(:message, caret: caret) { "Message about this particular piece of UI." }
        component.slot(:button) { "Got it!" }
      end
    end
  end
end
