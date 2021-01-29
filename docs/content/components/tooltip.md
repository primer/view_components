---
title: Tooltip
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/tooltip_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Tooltip component is a wrapper component that will apply a tooltip

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
```

### With a direction

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped tooltipped-nw '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: "nw")) { "Bold Text" } %>
```

### With an alignment

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped tooltipped-align-right-1 '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", alignment: "right-1")) { "Bold Text" } %>
```

### Without a delay

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped tooltipped-no-delay '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", delay: false)) { "Bold Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | the text to appear in the tooltip |
| `direction` | `String` | `` | Specify the direction of a tooltip with north, south, east, and west directions |
| `alignment` | `String` | `` | Align tooltips to the left or right of an element, combined with a directional class to specify north or south |
| `multiline` | `Boolean` | `` | Use this when you have long content |
| `delay` | `Boolean` | `true` | By default the tooltips have a slight delay before appearing. Set false to override this |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
