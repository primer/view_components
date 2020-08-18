# frozen_string_literal: true

class Primer::PopoverComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:body) { "Message about this particular piece of UI." }
    end
  end

  story(:popover_without_heading) do
    content do |component|
      component.slot(:body) { "Message about this particular piece of UI." }
    end
  end

  story(:large_popover) do
    content do |component|
      component.slot(:heading) { "Popover heading" }
      component.slot(:body, large: true) { "Message about this particular piece of UI." }
    end
  end

  (
    Primer::PopoverComponent::Body::CARET_MAPPINGS.keys -
    [Primer::PopoverComponent::Body::CARET_DEFAULT]
  ).each do |caret|
    story("popover_#{caret}".to_sym) do
      content do |component|
        component.slot(:heading) { "Popover heading" }
        component.slot(:body, caret: caret) { "Message about this particular piece of UI." }
      end
    end
  end
end
