# frozen_string_literal: true

class Primer::SelectMenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:select_menu) do
    controls do
      text(:message, "Message")
      select(:list_border, Primer::SelectMenuComponent::LIST_BORDER_CLASSES.keys, :all)
      loading false
      blankslate false
      align_right false
    end

    content do |component|
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_tabs) do
    content do |component|
      component.slot(:tab, selected: true) { "Tab 1" }
      component.slot(:tab) { "Tab 2" }
      component.slot(:item, tab: 1, divider: true) { "hello world" }
      component.slot(:item, tab: 1) { "It's nice to meet you." }
      component.slot(:item, tab: 2) { "foo bar" }
      component.slot(:item, tab: 2) { "baz" }
    end
  end

  story(:select_menu_with_header) do
    content do |component|
      component.slot(:header) { "A nice title" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_header_and_close_button) do
    content do |component|
      component.slot(:header, close_button: true) { "A nice title" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_filter) do
    content do |component|
      component.slot(:filter) { "filter description" }
      component.slot(:item) { "hello world" }
    end
  end

  story(:select_menu_with_footer) do
    content do |component|
      component.slot(:item) { "hello world" }
      component.slot(:footer) { "the end" }
    end
  end
end
