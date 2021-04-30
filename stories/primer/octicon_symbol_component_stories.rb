# frozen_string_literal: true

class Primer::OcticonSymbolComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:octicon_symbol_component) do
    content do |c|
      c.icon(name: :alert)
      c.icon(name: :check)
      c.icon(name: :x)
    end
  end
end
