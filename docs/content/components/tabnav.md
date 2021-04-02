---
title: TabNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tab_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-tab-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use TabNav to style navigation with a tab-based selected state, typically used for navigation placed at the top of the page.

## Examples

### Default

<Example src="  <div id='default' class='tabnav '>    <nav aria-label='Default' class='tabnav-tabs '>          <a href='#' aria-current='page' class='tabnav-tab '>          Tab 1    </a>          <a href='#' class='tabnav-tab '>          Tab 2    </a>          <a href='#' class='tabnav-tab '>          Tab 3    </a></nav></div>" />

```erb
<%= render(Primer::TabNavComponent.new(id: "default", label: "Default")) do |c| %>
  <% c.tab(selected: true, href: "#") { "Tab 1" }%>
  <% c.tab(href: "#") { "Tab 2" } %>
  <% c.tab(href: "#") { "Tab 3" } %>
<% end %>
```

### With icons and counters

<Example src="  <div id='with-icons-and-counters' class='tabnav '>    <nav aria-label='With icons and counters' class='tabnav-tabs '>          <a href='#' aria-current='page' class='tabnav-tab '>    <svg class='octicon octicon-star' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span>Item 1</span>    </a>          <a href='#' class='tabnav-tab '>    <svg class='octicon octicon-star' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span>Item 2</span>    <span title='10' class='Counter '>10</span></a>          <a href='#' class='tabnav-tab '>          <span>Item 3</span>    <span title='10' class='Counter '>10</span></a></nav></div>" />

```erb
<%= render(Primer::TabNavComponent.new(id: "with-icons-and-counters", label: "With icons and counters")) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.icon(icon: :star) %>
    <% t.text { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.icon(icon: :star) %>
    <% t.text { "Item 2" } %>
    <% t.counter(count: 10) %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.text { "Item 3" } %>
    <% t.counter(count: 10) %>
  <% end %>
<% end %>
```

### With panels

<Example src="<tab-container>  <div id='with-panels' class='tabnav '>    <nav aria-label='With panels' role='tablist' class='tabnav-tabs '>          <button type='button' role='tab' aria-selected='true' class='tabnav-tab '>          <span>Tab 1</span>    </button>          <button type='button' role='tab' class='tabnav-tab '>          <span>Tab 2</span>    </button>          <button type='button' role='tab' class='tabnav-tab '>          <span>Tab 3</span>    </button></nav></div>      <div role='tabpanel'>      Panel 1</div>      <div role='tabpanel' hidden='hidden'>      Panel 2</div>      <div role='tabpanel' hidden='hidden'>      Panel 3</div></tab-container>" />

```erb
<%= render(Primer::TabNavComponent.new(id: "with-panels", label: "With panels", with_panel: true)) do |c| %>
  <% c.tab(selected: true) do |t| %>
    <% t.text { "Tab 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.text { "Tab 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% c.tab do |t| %>
    <% t.text { "Tab 3" } %>
    <% t.panel do %>
      Panel 3
    <% end %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `id` | `String` | N/A | The element id. |
| `label` | `String` | N/A | Used to set the `aria-label` on the top level `<nav>` element. |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Tabs to be rendered. For more information, refer to [Tab](/components/tab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
