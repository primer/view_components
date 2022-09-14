# frozen_string_literal: true

class Primer::StateComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:state) do
    controls do
      title "this is the title"
      select(:scheme, Primer::StateComponent::SCHEME_OPTIONS, :default)
      select(:size, Primer::StateComponent::SIZE_OPTIONS, :default)
      select(:tag, Primer::StateComponent::TAG_OPTIONS, :span)
    end

    content do
      "This is a state!"
    end
  end
end
