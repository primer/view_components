# frozen_string_literal: true

class Primer::BlankslateComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:icon) do
    controls do
      icon "shield"
      title "It looks like we have discovered a vulnerability"
      select(:icon_size, Primer::OcticonComponent::SIZE_MAPPINGS.keys, :large)
    end
  end

  story(:image_src) do
    controls do
      image_src "https://github.githubassets.com/images/modules/site/features/security-icon.svg"
      image_alt "Security - secure vault"
      title "Millions of teams trust GitHub to keep their work safe"
    end
  end

  story(:description) do
    controls do
      title "It looks like we have discovered a vulnerability"
      description "Millions of teams trust GitHub to keep their work safe"
    end
  end

  story(:button) do
    controls do
      title "It looks like we have discovered a vulnerability"
      button_text "Fix issue"
      button_url "#"
    end
  end

  story(:link) do
    controls do
      title "It looks like we have discovered a vulnerability"
      link_text "Fix issue"
      link_url "#"
    end
  end
end
