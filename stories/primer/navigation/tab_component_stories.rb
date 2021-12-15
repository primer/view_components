# frozen_string_literal: true

require "primer/navigation/tab_component"

class Primer::Navigation::TabComponentStories < ViewComponent::Storybook::Stories
  layout "storybook_centered_preview"

  story(:tab) do
    constructor(
      selected: boolean(true),
      list: boolean(false),
      with_panel: boolean(false),
      classes: select(%w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    )

    # Have to explicitly call #slot to avoid method name conflict.
    slot(:text) { "Tab" }
  end

  story(:with_icon) do
    constructor(
      selected: boolean(true),
      list: boolean(false),
      with_panel: boolean(false),
      classes: select(%w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    )

    icon(icon: :star)
    slot(:text) { "Tab" }
  end

  story(:with_counter) do
    constructor(
      selected: boolean(true),
      list: boolean(false),
      with_panel: boolean(false),
      classes: select(%w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    )

    counter(count: 25)
    slot(:text) { "Tab" }
  end

  story(:full) do
    constructor(
      selected: boolean(true),
      list: boolean(false),
      with_panel: boolean(false),
      classes: select(%w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    )

    icon(icon: :star)
    counter(count: 25)
    slot(:text) { "Tab" }
  end

  story(:with_custom_html) do
    constructor(
      selected: boolean(true),
      list: boolean(false),
      with_panel: boolean(false),
      classes: select(%w[tabnav-tab UnderlineNav-item], "tabnav-tab")
    )

    content do
      "<div>This is my <strong>custom HTML</strong></div>".html_safe
    end
  end
end
