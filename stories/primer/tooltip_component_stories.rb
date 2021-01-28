# frozen_string_literal: true

class Primer::TooltipComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip_default) do
    controls do
      label "Now you know more"
    end

    content do
      "Now you know"
    end
  end
end
