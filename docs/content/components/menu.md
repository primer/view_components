---
title: Menu
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/menu_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-menu-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Menu` to create vertical lists of navigational links.

## Examples

### Default

<Example src="<nav class='menu'>  <span class='menu-heading'>    Heading</span>    <a href='#url' aria-current='page' class='menu-item'>    Item 1</a>    <a href='#url' class='menu-item'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>    With Icon</a>    <a href='#url' class='menu-item'>    <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' height='16' width='16' class='octicon octicon-check'>    <path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>    With Icon and Counter    <span title='25' class='Counter'>25</span></a></nav>" />

```erb
<%= render(Primer::MenuComponent.new) do |c| %>
  <% c.heading do %>
    Heading
  <% end %>
  <% c.item(selected: true, href: "#url") do %>
    Item 1
  <% end %>
  <% c.item(href: "#url") do %>
    <%= render(Primer::OcticonComponent.new("check")) %>
    With Icon
  <% end %>
  <% c.item(href: "#url") do %>
    <%= render(Primer::OcticonComponent.new("check")) %>
    With Icon and Counter
    <%= render(Primer::CounterComponent.new(count: 25)) %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Heading`

Optional menu heading

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Items`

Required list of navigational links

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | N/A | URL to be used for the Link |
| `selected` | `Boolean` | N/A | Whether the item is the current selection |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
