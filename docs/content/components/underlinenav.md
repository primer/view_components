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

<Example src="<nav class='UnderlineNav '>  <ul class='UnderlineNav-body list-style-none '>    <a href='#url'>Item 1</a></ul>    <span>    <button type='button' class='btn '>Button!</button></span></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new) do |component| %>
  <% component.body do %>
    <%= render(Primer::LinkComponent.new(href: "#url")) { "Item 1" } %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Align right

<Example src="<nav class='UnderlineNav UnderlineNav--right '>    <span>    <button type='button' class='btn '>Button!</button></span>  <ul class='UnderlineNav-body list-style-none '>    <a href='#url'>Item 1</a></ul></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(align: :right)) do |component| %>
  <% component.body do %>
    <%= render(Primer::LinkComponent.new(href: "#url")) { "Item 1" } %>
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

### `Body`

Use the body for the navigation items

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Actions`

Use actions for a call to action

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
