# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do
      "Click me"
    end
  end

  story(:with_icon) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.icon(icon: :star)
      "Click me"
    end
  end

  story(:with_counter) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.counter(count: 10)
      "Click me"
    end
  end

  story(:full) do
    controls do
      select(:scheme, Primer::ButtonComponent::SCHEME_OPTIONS, :primary)
      select(:variant, Primer::ButtonComponent::VARIANT_OPTIONS, :medium)
      select(:tag, Primer::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.icon(icon: :star)
      c.counter(count: 10)
      "Click me"
    end
  end
end
