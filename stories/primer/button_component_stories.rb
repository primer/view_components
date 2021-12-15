# frozen_string_literal: true

class Primer::ButtonComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    constructor(
      scheme: select(Primer::ButtonComponent::SCHEME_OPTIONS, :primary),
      variant: select(Primer::ButtonComponent::VARIANT_OPTIONS, :medium),
      tag: select(Primer::BaseButton::TAG_OPTIONS, :button),
      type: select(Primer::BaseButton::TYPE_OPTIONS, :button),
      group_item: boolean(false),
      dropdown: boolean(false),
      disabled: boolean(false)
    )

    content do
      "Click me"
    end
  end

  story(:with_leading_visual) do
    constructor(
      scheme: select(Primer::ButtonComponent::SCHEME_OPTIONS, :primary),
      variant: select(Primer::ButtonComponent::VARIANT_OPTIONS, :medium),
      tag: select(Primer::BaseButton::TAG_OPTIONS, :button),
      type: select(Primer::BaseButton::TYPE_OPTIONS, :button),
      group_item: boolean(false),
      dropdown: boolean(false),
      disabled: boolean(false)
    )

    slot(:leading_visual_icon, icon: :star)
    content do
      "Click me"
    end
  end

  story(:with_trailing_visual) do
    constructor(
      scheme: select(Primer::ButtonComponent::SCHEME_OPTIONS, :primary),
      variant: select(Primer::ButtonComponent::VARIANT_OPTIONS, :medium),
      tag: select(Primer::BaseButton::TAG_OPTIONS, :button),
      type: select(Primer::BaseButton::TYPE_OPTIONS, :button),
      group_item: boolean(false),
      dropdown: boolean(false),
      disabled: boolean(false)
    )

    slot(:trailing_visual_counter, count: 10)
    content do
      "Click me"
    end
  end

  story(:full) do
    constructor(
      scheme: select(Primer::ButtonComponent::SCHEME_OPTIONS, :primary),
      variant: select(Primer::ButtonComponent::VARIANT_OPTIONS, :medium),
      tag: select(Primer::BaseButton::TAG_OPTIONS, :button),
      type: select(Primer::BaseButton::TYPE_OPTIONS, :button),
      group_item: boolean(false),
      dropdown: boolean(false),
      disabled: boolean(false)
    )

    slot(:leading_visual_icon, icon: :star)
    slot(:trailing_visual_counter, count: 10)
    content do
      "Click me"
    end
  end
end
