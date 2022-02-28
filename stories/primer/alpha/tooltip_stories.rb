class Primer::Alpha::TooltipStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    controls do
      select(:direction, Primer::Alpha::TOOLTIP::DIRECTION, :direction)
      select(:type, Primer::Alpha::Tooltip::TYPE_OPTIONS, :description)
      for_id("someButton")
      text("This is tooltip content")
    end
  end
  end
