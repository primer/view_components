# frozen_string_literal: true

class Primer::TooltipStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    controls do
      label "Now you know more"
      select(:direction, Primer::Tooltip::DIRECTION_OPTIONS, :nw)
      select(:align, Primer::Tooltip::ALIGN_MAPPING.keys, :default)
      no_delay false
      multiline false
    end

    content do
      "Now you know"
    end
  end
end
