# frozen_string_literal: true

require "primer/button/base"
require "primer/button/link"

class Primer::Button::LinkStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:link) do
    controls do
      block false
      select(:type, Primer::Button::Base::TYPE_OPTIONS, Primer::Button::Base::DEFAULT_TYPE)
    end

    content do
      "Link"
    end
  end
end
