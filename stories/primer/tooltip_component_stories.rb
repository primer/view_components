# frozen_string_literal: true

class Primer::TooltipComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    controls do
      label "Now you know more"
      select(:direction, Primer::TooltipComponent::DIRECTION_OPTIONS, :nw)
      select(:align, Primer::TooltipComponent::ALIGN_MAPPING.keys, :default)
      no_delay false
      multiline false
    end

    content do
      "Now you know"
    end
  end
end
