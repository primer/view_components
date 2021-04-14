# frozen_string_literal: true

require "primer/button/base"

class Primer::Button::BaseStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:base) do
    controls do
      block false
      select(:tag, Primer::Button::Base::TAG_OPTIONS, Primer::Button::Base::DEFAULT_TAG)
      select(:type, Primer::Button::Base::TYPE_OPTIONS, Primer::Button::Base::DEFAULT_TYPE)
    end

    content do
      "Click me"
    end
  end
end
