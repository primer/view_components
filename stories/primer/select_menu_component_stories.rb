# frozen_string_literal: true

class Primer::SelectMenuComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:select_menu) do
    content do |component|
      component.slot(:modal) { "hello world" }
    end
  end

  story(:select_menu_with_message) do
    content do |component|
      component.slot(:modal, message: "Goodness me") { "hello world" }
    end
  end

  story(:select_menu_with_blankslate) do
    content do |component|
      component.slot(:modal, blankslate: true) { "No results" }
    end
  end

  story(:select_menu_with_loading) do
    content do |component|
      component.slot(:modal, loading: true) { "Loading..." }
    end
  end

  story(:select_menu_with_header) do
    content do |component|
      component.slot(:header) { "A nice title" }
      component.slot(:modal) { "hello world" }
    end
  end

  story(:select_menu_with_header_and_close_button) do
    content do |component|
      component.slot(:header) { "A nice title" }
      component.slot(:close_button) { "close me" }
      component.slot(:modal) { "hello world" }
    end
  end

  story(:select_menu_with_filter) do
    content do |component|
      component.slot(:filter) { "filter description" }
      component.slot(:modal) { "hello world" }
    end
  end

  story(:select_menu_with_footer) do
    content do |component|
      component.slot(:modal) { "hello world" }
      component.slot(:footer) { "the end" }
    end
  end
end
