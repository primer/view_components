# frozen_string_literal: true

class Primer::AvatarStackComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:avatar_stack) do
    controls do
      select(:align, Primer::AvatarStackComponent::ALIGN_OPTIONS, Primer::AvatarStackComponent::ALIGN_DEFAULT)
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end

  story(:three_plus) do
    controls do
      select(:align, Primer::AvatarStackComponent::ALIGN_OPTIONS, Primer::AvatarStackComponent::ALIGN_DEFAULT)
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end

  story(:tooltipped_body) do
    controls do
      select(:align, Primer::AvatarStackComponent::ALIGN_OPTIONS, Primer::AvatarStackComponent::ALIGN_DEFAULT)
      tooltipped true
      body_arguments(label: "This is a tooltip")
    end

    content do |component|
      component.avatar(src: "https://github.com/github.png", alt: "github")
      component.avatar(src: "https://github.com/github.png", alt: "github")
    end
  end
end
