# frozen_string_literal: true

class Primer::PopoverComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message) { "Message about this particular piece of UI." }
    end
  end

  story(:popover_without_heading) do
    content do |component|
      component.slot(:message) { "Message about this particular piece of UI." }
    end
  end

  story(:large_popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:message, large: true) { "Message about this particular piece of UI." }
    end
  end

  (
    Primer::PopoverComponent::Message::CARET_MAPPINGS.keys -
    [Primer::PopoverComponent::Message::CARET_DEFAULT]
  ).each do |caret|
    story("popover_#{caret}".to_sym) do
      content do |component|
        component.slot(:heading) { "Popover heading" }
        component.slot(:message, caret: caret) { "Message about this particular piece of UI." }
      end
    end
  end
end
