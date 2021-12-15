# frozen_string_literal: true

class Primer::StateComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:state) do
    constructor(
      title: text("this is the title"),
      scheme: select(Primer::StateComponent::SCHEME_OPTIONS, :default),
      size: select(Primer::StateComponent::SIZE_OPTIONS, :default),
      tag: select(Primer::StateComponent::TAG_OPTIONS, :span)
    )

    content do
      "This is a state!"
    end
  end
end
