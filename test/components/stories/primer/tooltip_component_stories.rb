# frozen_string_literal: true

class Primer::TooltipComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip) do
    controls do
      label "This is a tooltip"
      select(:direction, Primer::TooltipComponent::DIRECTION_OPTIONS.each_with_object({}) { |k, h| h[k] = k }, :n)
      multiline false
      no_delay false
    end

    content do
      "With tooltip"
    end
  end
end
