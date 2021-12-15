# frozen_string_literal: true

class Primer::TooltipStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    constructor(
      label: text("Now you know more"),
      direction: select(Primer::Tooltip::DIRECTION_OPTIONS, :nw),
      align: select(Primer::Tooltip::ALIGN_MAPPING.keys, :default),
      no_delay: boolean(false),
      multiline: boolean(false)
    )

    content do
      "Now you know"
    end
  end
end
