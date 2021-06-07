---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-layout-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Layout` to build a main/sidebar layout.

## Examples

### Default

<Example src="<div data-view-component='true' class='gutter-condensed gutter-lg d-flex'>  <div data-view-component='true' class='flex-shrink-0 col-9'>Main</div>    <div data-view-component='true' class='flex-shrink-0 col-3'>Sidebar</div></div>" />

```erb
<%= render(Primer::LayoutComponent.new) do |component| %>
  <% component.sidebar { "Sidebar" } %>
  <% component.main { "Main" } %>
<% end %>
```

### Left sidebar

<Example src="<div data-view-component='true' class='gutter-condensed gutter-lg d-flex'>    <div data-view-component='true' class='flex-shrink-0 col-3'>Sidebar</div>  <div data-view-component='true' class='flex-shrink-0 col-9'>Main</div></div>" />

```erb
<%= render(Primer::LayoutComponent.new(side: :left)) do |component| %>
  <% component.sidebar { "Sidebar" } %>
  <% component.main { "Main" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `responsive` | `Boolean` | `false` | Whether to collapse layout to a single column at smaller widths. |
| `side` | `Symbol` | `:right` | Which side to display the sidebar on. One of `:right` and `:left`. |
| `sidebar_col` | `Integer` | `3` | Sidebar column width. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Main`

The main content

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Sidebar`

The sidebar content

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
