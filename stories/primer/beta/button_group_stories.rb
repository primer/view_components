# frozen_string_literal: true

require "primer/beta/button_group"

class Primer::Beta::ButtonGroupStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_group) do
    controls do
      select(:size, Primer::ButtonComponent::SIZE_OPTIONS, :medium)
    end

    content do |c|
      c.button { "Button" }
      c.button(scheme: :primary) { "Primary" }
      c.button(scheme: :danger) { "Danger" }
      c.button(scheme: :outline) { "Outline" }
    end
  end
end
