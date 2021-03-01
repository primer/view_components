# frozen_string_literal: true

class Primer::BorderBoxComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:full_box) do
    content do |component|
      component.header { "Header" }
      component.body { "Body" }
      component.row { "Row one" }
      component.row { "Row two" }
      component.row { "Row three" }
      component.footer { "Footer" }
    end
  end

  story(:header) do
    content do |component|
      component.header { "Header" }
    end
  end

  story(:body) do
    content do |component|
      component.body { "Body" }
    end
  end

  story(:footer) do
    content do |component|
      component.footer { "Footer" }
    end
  end

  story(:rows) do
    content do |component|
      component.row { "Row one" }
      component.row { "Row two" }
      component.row { "Row three" }
    end
  end
end
