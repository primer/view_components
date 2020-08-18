# frozen_string_literal: true

class Primer::LayoutComponentStories < Primer::Stories
  layout "storybook_preview"

  story(:layout) do
    controls do
      responsive false
      select(:side, Primer::LayoutComponent::ALLOWED_SIDES.each_with_object({}) { |k, h| h[k] = k }, :right)
      sidebar_col 3
    end

    content do |component|
      component.with(:main) { "Main" }
      component.with(:sidebar) { "Sidebar" }
    end
  end
end
