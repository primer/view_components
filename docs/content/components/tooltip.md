---
title: Tooltip
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/tooltip_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Tooltip component is a wrapper component that will apply a tooltip to the provided content.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped tooltipped-n tooltipped-align-right-1 '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Bold Text" } %>
```

### With a direction

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span aria-label='Even bolder' class='tooltipped tooltipped-nw tooltipped-align-right-1 '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :nw)) { "Bold Text" } %>
```

### With an alignment

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span alignment='right_1' aria-label='Even bolder' class='tooltipped tooltipped-n tooltipped-align-right-1 '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", alignment: :right_1)) { "Bold Text" } %>
```

### Without a delay

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span delay='false' aria-label='Even bolder' class='tooltipped tooltipped-n tooltipped-align-right-1 '>Bold Text</span></body></html>"></iframe>

```erb
<%= render(Primer::TooltipComponent.new(label: "Even bolder", delay: false)) { "Bold Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | the text to appear in the tooltip |
| `direction` | `String` | `:n` | Direction of the tooltip. One of `:n`, `:nw`, `:n`, `:ne`, `:w`, `:e`, `:sw`, `:s`, or `:se`. |
| `align` | `String` | `:right_1` | Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. One of `:right_1`, `:right_1`, `:left_1`, `:right_2`, `:left_2`, `:right_1`, `:left_1`, `:right_2`, or `:left_2`. |
| `multiline` | `Boolean` | `:right_1` | Use this when you have long content |
| `no_delay` | `Boolean` | `false` | By default the tooltips have a slight delay before appearing. Set true to override this |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
