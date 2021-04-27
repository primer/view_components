---
title: TimeAgo
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/time_ago_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-time-ago-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `TimeAgo` to display a time relative to how long ago it was. This component requires JavaScript.

## Examples

### Default

<Example src="<time-ago datetime='1989-11-28T05:00:00Z' class='no-wrap'>Nov 28, 1989</time-ago>" />

```erb
<%= render(Primer::TimeAgoComponent.new(time: Time.at(628232400))) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `time` | `Time` | N/A | The time to be formatted |
| `micro` | `Boolean` | `false` | If true then the text will be formatted in "micro" mode, using as few characters as possible |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
