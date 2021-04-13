# frozen_string_literal: true

require "primer/button/base"

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::Button::Base::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::Button::Base::TAG_OPTIONS, :button)
      select(:type, Primer::Button::Base::TYPE_OPTIONS, :button)
      group_item false
    end
    content do
      "Click me"
    end
  end
end
