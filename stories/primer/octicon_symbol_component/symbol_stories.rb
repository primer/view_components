# frozen_string_literal: true

class Primer::OcticonSymbolComponent::SymbolStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:icon) do
    controls do
      text(:symbol, "alert")
      select(:size, Primer::OcticonComponent::SIZE_OPTIONS, Primer::OcticonComponent::SIZE_DEFAULT)
    end
  end
end
