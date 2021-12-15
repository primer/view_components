# frozen_string_literal: true

class Primer::SubheadComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:subhead) do
    constructor(spacious: boolean(false), hide_border: boolean(false))

    slot(:heading) { "My Profile Heading" }
    slot(:description) { "This is a description of my profile. I live on planet Earth. Sometimes." }
    slot(:actions, classes: "btn btn-sm") { "Link to personal website" }
  end

  story(:danger_heading) do
    slot(:heading, danger: true) { "Danger Heading" }
  end
end
