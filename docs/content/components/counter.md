---
title: Counter
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/counter_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Primer::CounterComponent to add a count to navigational elements and buttons.

## Examples

### Default

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><span title='25' class='Counter '>25</span></body></html>"></iframe>

```erb
<%= render(Primer::CounterComponent.new(count: 25)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `count` | `Integer, Float::INFINITY, nil` | `0` | The number to be displayed (e.x. # of issues, pull requests) |
| `scheme` | `Symbol` | `:default` | Color scheme. One of `SCHEME_MAPPINGS.keys`. |
| `limit` | `Integer, nil` | `5_000` | Maximum value to display. Pass `nil` for no limit. (e.x. if `count` == 6,000 and `limit` == 5000, counter will display "5,000+") |
| `hide_if_zero` | `Boolean` | `false` | If true, a `hidden` attribute is added to the counter if `count` is zero. |
| `text` | `String` | `""` | Text to display instead of count. |
| `round` | `Boolean` | `false` | Whether to apply our standard rounding logic to value. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
