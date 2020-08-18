# frozen_string_literal: true

class Primer::BorderBoxComponentStories < Primer::Stories
  layout "storybook_preview"

  story(:full_box) do
    content do |component|
      component.slot(:header) { "Header" }
      component.slot(:body) { "Body" }
      component.slot(:row) { "Row one" }
      component.slot(:row) { "Row two" }
      component.slot(:row) { "Row three" }
      component.slot(:footer) { "Footer" }
    end
  end

  story(:header) do
    content do |component|
      component.slot(:header) { "Header" }
    end
  end

  story(:body) do
    content do |component|
      component.slot(:body) { "Body" }
    end
  end

  story(:footer) do
    content do |component|
      component.slot(:footer) { "Footer" }
    end
  end

  story(:rows) do
    content do |component|
      component.slot(:row) { "Row one" }
      component.slot(:row) { "Row two" }
      component.slot(:row) { "Row three" }
    end
  end
end
