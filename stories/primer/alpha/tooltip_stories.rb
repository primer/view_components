# frozen_string_literal: true

require "primer/alpha/tooltip"

class Primer::Alpha::TooltipStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    controls do
      select(:direction, Primer::Alpha::Tooltip::DIRECTION_OPTIONS, :s)
      select(:type, Primer::Alpha::Tooltip::TYPE_OPTIONS, :description)
      text(:for_id, "someButton")
      text(:text, "This is tooltip text")
    end
  end
end
