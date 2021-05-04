---
title: Counter
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/counter_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-counter-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `Counter` to add a count to navigational elements and buttons.

## Accessibility

Always use `Counter` with adjacent text that provides supplementary information regarding what the count is for. For instance, `Counter`
should be accompanied with text such as `issues` or `pull requests`.

## Examples

### Default

<Example src="<span title='25' class='Counter'>25</span>" />

```erb
<%= render(Primer::CounterComponent.new(count: 25)) %>
```

### Schemes

<Example src="<span title='25' class='Counter Counter--primary'>25</span><span title='25' class='Counter Counter--secondary'>25</span>" />

```erb
<%= render(Primer::CounterComponent.new(count: 25, scheme: :primary)) %>
<%= render(Primer::CounterComponent.new(count: 25, scheme: :secondary)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `count` | `Integer, Float::INFINITY, nil` | `0` | The number to be displayed (e.x. # of issues, pull requests) |
| `scheme` | `Symbol` | `:default` | Color scheme. One of `:default`, `:primary`, or `:secondary`. |
| `limit` | `Integer, nil` | `5_000` | Maximum value to display. Pass `nil` for no limit. (e.x. if `count` == 6,000 and `limit` == 5000, counter will display "5,000+") |
| `hide_if_zero` | `Boolean` | `false` | If true, a `hidden` attribute is added to the counter if `count` is zero. |
| `text` | `String` | `""` | Text to display instead of count. |
| `round` | `Boolean` | `false` | Whether to apply our standard rounding logic to value. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
