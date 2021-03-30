---
title: List
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/list_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-list-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use List to create simple `<ul>` `<li>` HTML lists.

## Examples

### Default

<Example src="<ul>    <li>Item 1</li>    <li>Item 2</li>    <li>Item 3</li></ul>" />

```erb
<%= render(Primer::ListComponent.new) do |c| %>
  <%= c.item { "Item 1" } %>
  <%= c.item { "Item 2" } %>
  <%= c.item { "Item 3" } %>
<% end  %>
```

### Unstyled list

<Example src="<ul class='list-style-none '>    <li>Item 1</li>    <li>Item 2</li>    <li>Item 3</li></ul>" />

```erb
<%= render(Primer::ListComponent.new(unstyled: true)) do |c| %>
  <%= c.item { "Item 1" } %>
  <%= c.item { "Item 2" } %>
  <%= c.item { "Item 3" } %>
<% end  %>
```

### Unstyled item

<Example src="<ul>    <li>Item 1</li>    <li class='list-style-none '>Item 2</li>    <li>Item 3</li></ul>" />

```erb
<%= render(Primer::ListComponent.new) do |c| %>
  <%= c.item { "Item 1" } %>
  <%= c.item(unstyled: true) { "Item 2" } %>
  <%= c.item { "Item 3" } %>
<% end  %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `unstyled` | `Boolean` | `false` | Whether the list should be unstyled. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

Required list of items.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `unstyled` | `Boolean` | N/A | Whether the item should be unstyled. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
