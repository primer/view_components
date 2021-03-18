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
