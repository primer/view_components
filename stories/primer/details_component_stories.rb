# frozen_string_literal: true

class Primer::DetailsComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:details) do
    controls do
      select(:overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      reset false
    end

    content do |component|
      component.summary { "Click me" }
      component.body { "Body" }
    end
  end

  story(:custom_button) do
    controls do
      select(:overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
    end

    content do |component|
      component.summary(size: :small, scheme: :primary) { "Click me" }
      component.body { "Body" }
    end
  end

  story(:without_button) do
    controls do
      select(:overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
    end

    content do |component|
      component.summary(button: false) { "Click me" }
      component.body { "Body" }
    end
  end
end
