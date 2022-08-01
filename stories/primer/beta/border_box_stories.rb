# frozen_string_literal: true

require "primer/beta/border_box"

class Primer::BorderBoxComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:full_box) do
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

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
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

    content do |component|
      component.header { "Header" }
    end
  end

  story(:header_title) do
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

    content do |component|
      component.header do |h|
        h.title(tag: :h2) { "Title" }
      end
    end
  end

  story(:body) do
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

    content do |component|
      component.body { "Body" }
    end
  end

  story(:footer) do
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

    content do |component|
      component.footer { "Footer" }
    end
  end

  story(:rows) do
    controls do
      select(:padding, Primer::BorderBoxComponent::PADDING_MAPPINGS.keys, Primer::BorderBoxComponent::DEFAULT_PADDING)
    end

    content do |component|
      component.row { "Row one" }
      component.row { "Row two" }
      component.row { "Row three" }
    end
  end
end
