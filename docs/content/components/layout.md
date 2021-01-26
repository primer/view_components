---
title: Layout
status: Experimental
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Layout to build a main/sidebar layout.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='gutter-condensed gutter-lg d-flex'>  <div class='flex-shrink-0 col-9'>    Main</div>    <div class='flex-shrink-0 col-3'>      Sidebar</div></div></body></html>"></iframe>

```erb
<%= render(Primer::LayoutComponent.new) do |component| %>
  <% component.with(:sidebar) { "Sidebar" } %>
  <% component.with(:main) { "Main" } %>
<% end %>
```

### Left sidebar

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='gutter-condensed gutter-lg d-flex'>    <div class='flex-shrink-0 col-3'>      Sidebar</div>  <div class='flex-shrink-0 col-9'>    Main</div></div></body></html>"></iframe>

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
