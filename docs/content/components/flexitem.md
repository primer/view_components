---
title: FlexItem
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/flex_item_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use FlexItemComponent to specify the ability of a flex item to alter its
dimensions to fill available space

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><div class='d-flex'>  <div>    Item 1</div>  <div class='flex-auto '>    Item 2</div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlexComponent.new) do %>
  <%= render(Primer::FlexItemComponent.new) do %>
    Item 1
  <% end %>

  <%= render(Primer::FlexItemComponent.new(flex_auto: true)) do %>
    Item 2
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `flex_auto` | `Boolean` | `false` | Fills available space and auto-sizes based on the content. Defaults to false |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
