# frozen_string_literal: true

require "primer/beta/close_button"

class Primer::Beta::CloseButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:close_button) do
    controls do
      select(:type, Primer::Beta::CloseButton::TYPE_OPTIONS, Primer::Beta::CloseButton::DEFAULT_TYPE)
    end
  end
end
