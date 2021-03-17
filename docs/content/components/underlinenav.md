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

<Example src="<nav class='UnderlineNav '>  <div class='UnderlineNav-body '>      <a role='tab' aria-current='page' class='UnderlineNav-item '>    Item 1</a>      <a role='tab' class='UnderlineNav-item '>    Item 2</a></div>    <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new) do |component| %>
  <% component.tab(href: "#", selected: true) do %>
    Item 1
  <% end %>
  <% component.tab(href: "#") do %>
    Item 2
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Align right

<Example src="<nav class='UnderlineNav UnderlineNav--right '>    <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div>  <div class='UnderlineNav-body '>      <a role='tab' aria-current='page' class='UnderlineNav-item '>    Item 1</a>      <a role='tab' class='UnderlineNav-item '>    Item 2</a></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(align: :right)) do |component| %>
  <% component.tab(href: "#", selected: true) do %>
    Item 1
  <% end %>
  <% component.tab(href: "#") do %>
    Item 2
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With panels

<Example src="<nav class='UnderlineNav '>  <div class='UnderlineNav-body '>      <button role='tab' type='button' aria-selected='true' class='UnderlineNav-item '>    Item 1</button>      <button role='tab' type='button' class='UnderlineNav-item '>    Item 2</button></div>    <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>    <div role='tabpanel' >            Panel 1    </div>    <div role='tabpanel' hidden>            Panel 2    </div>" />

```erb
<%= render(Primer::UnderlineNavComponent.new) do |component| %>
  <% component.tab(selected: true) do |t| %>
    Item 1
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab do |t| %>
    Item 2
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
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Tabs`

Use the tabs to list navigation items.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Use actions for a call to action.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
