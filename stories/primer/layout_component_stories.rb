# frozen_string_literal: true

class Primer::LayoutComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      responsive false
      select(:side, Primer::LayoutComponent::ALLOWED_SIDES, :right)
      sidebar_col 3
    end

    content do |component|
      component.main { "Main" }
      component.sidebar { "Sidebar" }
    end
  end
end
