# frozen_string_literal: true

class Primer::SelectMenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:select_menu) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_header) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.slot(:header) { "A nice title" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_header_and_close_button) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.slot(:header, close_button: true) { "A nice title" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_filter) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.slot(:filter) { "filter description" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_footer) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary) { "Click me" }
      component.slot(:item) { "hello world" }
      component.slot(:footer) { "the end" }
    end
  end

  story(:select_menu_with_custom_button) do
    controls do
      text(:message, "Message")
      select(:details_overlay, Primer::DetailsComponent::OVERLAY_MAPPINGS.keys, :none)
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
      reset_details false
    end

    content do |component|
      component.slot(:summary, variant: :small, button_type: :primary) { "Click me" }
      component.slot(:item) { "hello world" }
    end
  end
end
