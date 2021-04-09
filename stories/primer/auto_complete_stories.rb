# frozen_string_literal: true

class Primer::AutoCompleteStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete) do
    controls do
      text(:src, "/")
      text(:id, "id")
    end

    content do |c|
      c.input(name: "username")
      c.icon(icon: :search)
    end
  end
end
