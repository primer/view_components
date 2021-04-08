# frozen_string_literal: true

require "primer/navigation/tab_component"

class Primer::Navigation::TabComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:tab) do
    controls do
      selected true
      list false
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do |c|
      c.text { "Tab" }
    end
  end

  story(:with_icon) do
    controls do
      selected true
      list false
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do |c|
      c.icon(icon: :star)
      c.text { "Tab" }
    end
  end

  story(:with_counter) do
    controls do
      selected true
      list false
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do |c|
      c.counter(count: 25)
      c.text { "Tab" }
    end
  end

  story(:full) do
    controls do
      selected true
      list false
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do |c|
      c.icon(icon: :star)
      c.counter(count: 25)
      c.text { "Tab" }
    end
  end

  story(:with_custom_html) do
    controls do
      selected true
      list false
      with_panel false
      select(:classes, %w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    end

    content do |_c|
      "<div>This is my <strong>custom HTML</strong></div>".html_safe
    end
  end
end
