---
title: UnderlineNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/underline_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-underline-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use the UnderlineNav component to style navigation with a minimal
underlined selected state, typically used for navigation placed at the top
of the page.

## Examples

### Default

<Example src="  <nav role='tablist' class='UnderlineNav '>    <div class='UnderlineNav-body '>        <a href='#' role='tab' aria-current='page' class='UnderlineNav-item '>          Item 1</a>        <a href='#' role='tab' class='UnderlineNav-item '>          Item 2</a></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new) do |component| %>
  <% component.tab(href: "#", selected: true) { "Item 1" } %>
  <% component.tab(href: "#") { "Item 2" } %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With icons and counters

<Example src="  <nav role='tablist' class='UnderlineNav '>    <div class='UnderlineNav-body '>        <a href='#' role='tab' aria-current='page' class='UnderlineNav-item '>  <svg class='octicon octicon-star UnderlineNav-octicon' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>  <span>Item 1</span>  </a>        <a href='#' role='tab' class='UnderlineNav-item '>  <svg class='octicon octicon-star UnderlineNav-octicon' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>  <span>Item 2</span>  <span title='10' class='Counter '>10</span></a>        <a href='#' role='tab' class='UnderlineNav-item '>    <span>Item 3</span>  <span title='10' class='Counter '>10</span></a></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.icon(icon: :star) %>
    <% t.title { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.icon(icon: :star) %>
    <% t.title { "Item 2" } %>
    <% t.counter(count: 10) %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.title { "Item 3" } %>
    <% t.counter(count: 10) %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Align right

<Example src="  <nav role='tablist' class='UnderlineNav UnderlineNav--right '>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div>    <div class='UnderlineNav-body '>        <a href='#' role='tab' aria-current='page' class='UnderlineNav-item '>    <span>Item 1</span>  </a>        <a href='#' role='tab' class='UnderlineNav-item '>    <span>Item 2</span>  </a></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(align: :right)) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.title { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.title { "Item 2" } %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With panels

<Example src="<tab-container>  <nav role='tablist' class='UnderlineNav '>    <div class='UnderlineNav-body '>        <button role='tab' type='button' aria-selected='true' class='UnderlineNav-item '>    <span>Item 1</span>  </button>        <button role='tab' type='button' class='UnderlineNav-item '>    <span>Item 2</span>  </button></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>      <div role='tabpanel'>      Panel 1</div>      <div role='tabpanel' hidden='hidden'>      Panel 2</div></tab-container>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(with_panel: true)) do |component| %>
  <% component.tab(selected: true) do |t| %>
    <% t.title { "Item 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab do |t| %>
    <% t.title { "Item 2" } %>
    <% t.panel do %>
      Panel 2
    <% end %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use the tabs to list navigation items. For more information, refer to [Tab](/components/tab).

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | N/A | Whether the tab is selected. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Use actions for a call to action.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
