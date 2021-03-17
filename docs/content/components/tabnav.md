---
title: TabNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-tab-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabNav to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.

## Examples

### Default

<Example src="<div class='tabnav '>  <nav role='tablist' aria-label='' class='tabnav-tabs'>      <a title='Tab 1' href='#' role='tab' aria-current='page' class='tabnav-tab '></a>      <a title='Tab 2' href='#' role='tab' class='tabnav-tab '></a>      <a title='Tab 3' href='#' role='tab' class='tabnav-tab '></a>  </nav ></div>" />

```erb
<%= render(Primer::TabNavComponent.new) do |c| %>
  <% c.tab(selected: true, title: "Tab 1", href: "#") %>
  <% c.tab(title: "Tab 2", href: "#") %>
  <% c.tab(title: "Tab 3", href: "#") %>
<% end %>
```

### With panels

<Example src="<tab-container class='tabnav '>  <nav role='tablist' aria-label='' class='tabnav-tabs'>      <button title='Tab 1' role='tab' type='button' aria-selected='true' class='tabnav-tab '>Panel 1</button>      <button title='Tab 2' role='tab' type='button' class='tabnav-tab '>Panel 1</button>      <button title='Tab 3' role='tab' type='button' class='tabnav-tab '>Panel 1</button>  </nav >                  </tab-container>" />

```erb
<%= render(Primer::TabNavComponent.new(with_panel: true)) do |c| %>
  <% c.tab(selected: true, title: "Tab 1") { "Panel 1" } %>
  <% c.tab(title: "Tab 2") { "Panel 1" } %>
  <% c.tab(title: "Tab 3") { "Panel 1" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `aria_label` | `String` | `nil` | Used to set the `aria-label` on the top level `<nav>` element. |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Tabs to be rendered.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
