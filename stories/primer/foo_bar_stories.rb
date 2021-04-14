# frozen_string_literal: true

class Primer::FooBarStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:foo_bar) do
    contols do
      classes "custom-class"
    end

    content do
      "Update your stories!"
    end
  end
end
