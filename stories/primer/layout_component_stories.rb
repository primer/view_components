# frozen_string_literal: true

class Primer::LayoutComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:layout) do
    constructor(
      responsive: boolean(false),
      side: select(Primer::LayoutComponent::ALLOWED_SIDES, :right),
      sidebar_col: number(3)
    )

    main { "Main" }
    sidebar { "Sidebar" }
  end
end
