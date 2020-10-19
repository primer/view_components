# frozen_string_literal: true

class Primer::BoxComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:box) do
    content do
      "This is a div"
    end
  end
end
