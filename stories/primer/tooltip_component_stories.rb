# frozen_string_literal: true

class Primer::TooltipComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:tooltip) do
    # controls do
    #   direction
    # end

    content do
      "Now you know"
    end
  end
end
