---
title: Tooltip
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/tooltip_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Tooltip component is a wrapper component that will apply a tooltip

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span label='Even bolder'>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
