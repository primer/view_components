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

<Example src="  <div class='tabnav '>    <nav role='tablist' aria-label='' class='tabnav-tabs'>        <a href='#' role='tab' aria-current='page' class='tabnav-tab '>          Tab 1</a>        <a href='#' role='tab' class='tabnav-tab '>          Tab 2</a>        <a href='#' role='tab' class='tabnav-tab '>          Tab 3</a>    </nav></div>" />

```erb
<%= render(Primer::TabNavComponent.new) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```

### With panels

<Example src="<tab-container>  <div class='tabnav '>    <nav role='tablist' aria-label='' class='tabnav-tabs'>        <button role='tab' type='button' aria-selected='true' class='tabnav-tab '>    <span>Tab 1</span>  </button>        <button role='tab' type='button' class='tabnav-tab '>    <span>Tab 2</span>  </button>        <button role='tab' type='button' class='tabnav-tab '>    <span>Tab 3</span>  </button>    </nav></div>      <div role='tabpanel'>      Panel 1</div>      <div role='tabpanel' hidden='hidden'>      Panel 2</div>      <div role='tabpanel' hidden='hidden'>      Panel 3</div></tab-container>" />

```erb
<%= render(Primer::TabNavComponent.new(with_panel: true)) do |c| %>
  <% c.tab(selected: true) do |t| %>
    <% t.title { "Tab 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.title { "Tab 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.title { "Tab 3" } %>
    <% t.panel do %>
      Panel 3
    <% end %>
  <% end %>
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

Tabs to be rendered. For more information, refer to [Tab](/components/tab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
