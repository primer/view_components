---
title: UnderlineNav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/underline_nav_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-underline-nav-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use the UnderlineNav component to style navigation with a minimal
underlined selected state, typically used for navigation placed at the top
of the page.

## Examples

### Default

<Example src="  <nav id='default' aria-label='Default' class='UnderlineNav '>    <div class='UnderlineNav-body '>          <a href='#' id='default-0' aria-current='page' class='UnderlineNav-item '>          Item 1    </a>          <a href='#' id='default-1' class='UnderlineNav-item '>          Item 2    </a></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(id: "default", label: "Default")) do |component| %>
  <% component.tab(href: "#", selected: true) { "Item 1" } %>
  <% component.tab(href: "#") { "Item 2" } %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With icons and counters

<Example src="  <nav id='with-icons-and-counters' aria-label='With icons and counters' class='UnderlineNav '>    <div class='UnderlineNav-body '>          <a href='#' id='with-icons-and-counters-0' aria-current='page' class='UnderlineNav-item '>    <svg class='octicon octicon-star UnderlineNav-octicon' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span>Item 1</span>    </a>          <a href='#' id='with-icons-and-counters-1' class='UnderlineNav-item '>    <svg class='octicon octicon-star UnderlineNav-octicon' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z'></path></svg>      <span>Item 2</span>    <span title='10' class='Counter '>10</span></a>          <a href='#' id='with-icons-and-counters-2' class='UnderlineNav-item '>          <span>Item 3</span>    <span title='10' class='Counter '>10</span></a></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(id: "with-icons-and-counters", label: "With icons and counters")) do |component| %>
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
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### Align right

<Example src="  <nav id='align-right' aria-label='Align right' class='UnderlineNav UnderlineNav--right '>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div>    <div class='UnderlineNav-body '>          <a href='#' id='align-right-0' aria-current='page' class='UnderlineNav-item '>          <span>Item 1</span>    </a>          <a href='#' id='align-right-1' class='UnderlineNav-item '>          <span>Item 2</span>    </a></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(id: "align-right", label: "Align right", align: :right)) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.text { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.text { "Item 2" } %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### As a list

<Example src="  <nav id='as-a-list' aria-label='As a list' class='UnderlineNav '>    <ul class='UnderlineNav-body list-style-none '>        <li class='d-flex'>  <a href='#' id='as-a-list-0' aria-current='page' class='UnderlineNav-item '>          <span>Item 1</span>    </a></li>        <li class='d-flex'>  <a href='#' id='as-a-list-1' class='UnderlineNav-item '>          <span>Item 2</span>    </a></li></ul>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(id: "as-a-list", label: "As a list", body_arguments: { tag: :ul })) do |component| %>
  <% component.tab(href: "#", selected: true) do |t| %>
    <% t.text { "Item 1" } %>
  <% end %>
  <% component.tab(href: "#") do |t| %>
    <% t.text { "Item 2" } %>
  <% end %>
  <% component.actions do %>
    <%= render(Primer::ButtonComponent.new) { "Button!" } %>
  <% end %>
<% end %>
```

### With panels

<Example src="<tab-container>  <nav id='with-panels' aria-label='With panels' class='UnderlineNav '>    <div role='tablist' aria-labelledby='with-panels' class='UnderlineNav-body '>          <button aria-controls='with-panels-0-panel' id='with-panels-0' type='button' role='tab' aria-selected='true' class='UnderlineNav-item '>          <span>Item 1</span>    </button>          <button aria-controls='with-panels-1-panel' id='with-panels-1' type='button' role='tab' class='UnderlineNav-item '>          <span>Item 2</span>    </button></div>      <div class='UnderlineNav-actions '>    <button type='button' class='btn '>Button!</button></div></nav>      <div role='tabpanel' aria-labelledby='with-panels-0' id='with-panels-0-panel'>      Panel 1</div>      <div role='tabpanel' hidden='hidden' aria-labelledby='with-panels-1' id='with-panels-1-panel'>      Panel 2</div></tab-container>" />

```erb
<%= render(Primer::UnderlineNavComponent.new(id: "with-panels", label: "With panels", with_panel: true)) do |component| %>
  <% component.tab(selected: true) do |t| %>
    <% t.text { "Item 1" } %>
    <% t.panel do %>
      Panel 1
    <% end %>
  <% end %>
  <% component.tab do |t| %>
    <% t.text { "Item 2" } %>
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
| `id` | `String` | N/A | The element id. |
| `label` | `String` | N/A | The `aria-label` on top level `<nav>` element. |
| `with_panel` | `Boolean` | `false` | Whether the TabNav should navigate through pages or panels. |
| `align` | `Symbol` | `:left` | One of `:left` and `:right`. - Defaults to left |
| `body_arguments` | `Hash` | `{ tag: BODY_TAG_DEFAULT }` | [System arguments](/system-arguments) for the body wrapper. |
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
