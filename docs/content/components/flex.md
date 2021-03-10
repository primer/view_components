---
title: Flex
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-flex-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use FlexComponent to make an element lay out its content using the flexbox model.
Before using these utilities, you should be familiar with CSS3 Flexible Box
spec. If you are not, check out MDN's guide  [Using CSS Flexible
Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox).

## Examples

### Default

<Example src="<div class='color-bg-tertiary d-flex'>  <div class='border p-5 color-bg-secondary'>Item 1</div>  <div class='border p-5 color-bg-secondary'>Item 2</div>  <div class='border p-5 color-bg-secondary'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(bg: :tertiary)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 3" } %>
<% end %>
```

### Justify center

<Example src="<div class='flex-justify-center color-bg-tertiary d-flex'>  <div class='border p-5 color-bg-secondary'>Item 1</div>  <div class='border p-5 color-bg-secondary'>Item 2</div>  <div class='border p-5 color-bg-secondary'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(justify_content: :center, bg: :tertiary)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 3" } %>
<% end %>
```

### Align end

<Example src="<div class='flex-items-end color-bg-tertiary d-flex'>  <div class='border p-5 color-bg-secondary'>Item 1</div>  <div class='border p-5 color-bg-secondary'>Item 2</div>  <div class='border p-5 color-bg-secondary'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(align_items: :end, bg: :tertiary)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 3" } %>
<% end %>
```

### Direction column

<Example src="<div class='color-bg-tertiary flex-column d-flex'>  <div class='border p-5 color-bg-secondary'>Item 1</div>  <div class='border p-5 color-bg-secondary'>Item 2</div>  <div class='border p-5 color-bg-secondary'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(direction: :column, bg: :tertiary)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :secondary, classes: "border")) { "Item 3" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `justify_content` | `Symbol` | `JUSTIFY_CONTENT_DEFAULT` | Use this param to distribute space between and around flex items along the main axis of the container. One of `nil`, `:flex_start`, `:flex_end`, `:center`, `:space_between`, or `:space_around`. |
| `inline` | `Boolean` | `false` | Defaults to false. |
| `flex_wrap` | `Boolean` | `FLEX_WRAP_DEFAULT` | Defaults to nil. |
| `align_items` | `Symbol` | `ALIGN_ITEMS_DEFAULT` | Use this param to align items on the cross axis. One of `nil`, `:start`, `:end`, `:center`, `:baseline`, or `:stretch`. |
| `direction` | `Symbol` | `nil` | Use this param to define the orientation of the main axis (row or column). By default, flex items will display in a row. One of `nil`, `:column`, `:column_reverse`, `:row`, or `:row_reverse`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
