# frozen_string_literal: true

class Primer::OcticonSymbolsComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:octicon_symbols_component) do
    controls do
      text(:icons, [
        {
          symbol: :alert
        }
      ])
    end
  end
end
