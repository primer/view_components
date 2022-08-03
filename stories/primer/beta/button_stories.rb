# frozen_string_literal: true

require "primer/beta/button"

class Primer::Beta::ButtonStories < ViewComponent::Storybook::Stories
  layout "storybook_preview"

  story(:button) do
    controls do
      select(:scheme, Primer::Beta::Button::SCHEME_OPTIONS, :primary)
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do
      "Click me"
    end
  end

  story(:with_tooltip) do
    controls do
      select(:scheme, Primer::Beta::Button::SCHEME_OPTIONS, :primary)
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, :button)
      text(:id, "button-with-tooltip")
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.tooltip(text: "Tooltip text")
      "Click me"
    end
  end

  story(:with_leading_visual) do
    controls do
      select(:scheme, Primer::Beta::Button::SCHEME_OPTIONS, :primary)
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.leading_visual_icon(icon: :star)
      "Click me"
    end
  end

  story(:with_trailing_visual) do
    controls do
      select(:scheme, Primer::Beta::Button::SCHEME_OPTIONS, :primary)
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.trailing_visual_counter(count: 10)
      "Click me"
    end
  end

  story(:full) do
    controls do
      select(:scheme, Primer::Beta::Button::SCHEME_OPTIONS, :primary)
      select(:size, Primer::Beta::Button::SIZE_OPTIONS, :medium)
      select(:tag, Primer::Beta::BaseButton::TAG_OPTIONS, :button)
      select(:type, Primer::Beta::BaseButton::TYPE_OPTIONS, :button)
      group_item false
      dropdown false
      disabled false
    end

    content do |c|
      c.leading_visual_icon(icon: :star)
      c.trailing_visual_counter(count: 10)
      "Click me"
    end
  end
end
