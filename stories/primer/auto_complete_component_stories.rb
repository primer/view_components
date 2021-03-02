# frozen_string_literal: true

class Primer::AutoCompleteComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:auto_complete) do
    controls do
      text(:src, "/")
      text(:id, "id")
    end

    content do |c|
      c.input(type: :text, name: "username")
      c.icon(icon: :search)
    end
  end
end
