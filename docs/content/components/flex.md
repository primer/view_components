---
title: Flex
componentId: flex
status: Deprecated
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-flex-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Flex` to make an element lay out its content using the flexbox model.
Before using these utilities, you should be familiar with CSS3 Flexible Box
spec. If you are not, check out MDN's guide  [Using CSS Flexible
Boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox).

## Deprecation

Use [Box](/components/box) instead.

**Before**:

```erb
<%= render Primer::FlexComponent.new(justify_content: :center) %>
<%= render Primer::FlexComponent.new(inline: true) %>
<%= render Primer::FlexComponent.new(flex_wrap: true) %>
<%= render Primer::FlexComponent.new(align_items: :start) %>
<%= render Primer::FlexComponent.new(direction: :column) %>
```

**After**:

```erb
<%= render Primer::BoxComponent.new(display: :flex, justify_content: :center) %>
<%= render Primer::BoxComponent.new(display: :inline_flex) %>
<%= render Primer::BoxComponent.new(display: :flex, flex_wrap: :wrap) %>
<%= render Primer::BoxComponent.new(display: :flex, align_items: :start) %>
<%= render Primer::BoxComponent.new(display: :flex, direction: :column) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `justify_content` | `Symbol` | `JUSTIFY_CONTENT_DEFAULT` | Use this param to distribute space between and around flex items along the main axis of the container. One of `nil`, `:center`, `:flex_end`, `:flex_start`, `:space_around`, or `:space_between`. |
| `inline` | `Boolean` | `false` | Defaults to false. |
| `flex_wrap` | `Boolean` | `FLEX_WRAP_DEFAULT` | Defaults to nil. |
| `align_items` | `Symbol` | `ALIGN_ITEMS_DEFAULT` | Use this param to align items on the cross axis. One of `nil`, `:baseline`, `:center`, `:end`, `:start`, or `:stretch`. |
| `direction` | `Symbol` | `nil` | Use this param to define the orientation of the main axis (row or column). By default, flex items will display in a row. One of `nil`, `:column`, `:column_reverse`, `:row`, or `:row_reverse`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true' class='color-bg-subtle d-flex'>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 1</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 2</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(bg: :subtle)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
<% end %>
```

### Justify center

<Example src="<div data-view-component='true' class='flex-justify-center color-bg-subtle d-flex'>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 1</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 2</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(justify_content: :center, bg: :subtle)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
<% end %>
```

### Align end

<Example src="<div data-view-component='true' class='flex-items-end color-bg-subtle d-flex'>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 1</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 2</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(align_items: :end, bg: :subtle)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
<% end %>
```

### Direction column

<Example src="<div data-view-component='true' class='color-bg-subtle flex-column d-flex'>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 1</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 2</div>  <div data-view-component='true' class='border p-5 color-bg-subtle'>Item 3</div></div>" />

```erb
<%= render(Primer::FlexComponent.new(direction: :column, bg: :subtle)) do %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 1" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 2" } %>
  <%= render(Primer::BoxComponent.new(p: 5, bg: :subtle, classes: "border")) { "Item 3" } %>
<% end %>
```
