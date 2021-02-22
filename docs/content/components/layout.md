---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout_component.rb
storybook: https://primer-view-components.herokuapp.com/?path=/story/primer-layout-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Layout to build a main/sidebar layout.

## Examples

### Default

<IFrame height="auto" content="<div class='gutter-condensed gutter-lg d-flex'>  <div class='flex-shrink-0 col-9'>    Main</div>    <div class='flex-shrink-0 col-3'>      Sidebar</div></div>"></IFrame>

```erb
<%= render(Primer::LayoutComponent.new) do |component| %>
  <% component.with(:sidebar) { "Sidebar" } %>
  <% component.with(:main) { "Main" } %>
<% end %>
```

### Left sidebar

<IFrame height="auto" content="<div class='gutter-condensed gutter-lg d-flex'>    <div class='flex-shrink-0 col-3'>      Sidebar</div>  <div class='flex-shrink-0 col-9'>    Main</div></div>"></IFrame>

```erb
<%= render(Primer::LayoutComponent.new(side: :left)) do |component| %>
  <% component.with(:sidebar) { "Sidebar" } %>
  <% component.with(:main) { "Main" } %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `responsive` | `Boolean` | `false` | Whether to collapse layout to a single column at smaller widths. |
| `side` | `Symbol` | `:right` | Which side to display the sidebar on. One of `:right` and `:left`. |
| `sidebar_col` | `Integer` | `3` | Sidebar column width. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
