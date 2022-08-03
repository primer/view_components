# frozen_string_literal: true

class Primer::ButtonGroupStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button_group) do
    controls do
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
    end

    content do |c|
      c.button { "Button" }
      c.button(scheme: :primary) { "Primary" }
      c.button(scheme: :danger) { "Danger" }
      c.button(scheme: :outline) { "Outline" }
    end
  end
end
