---
title: TimeAgo
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/time_ago_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-time-ago-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Primer::TimeAgoComponent to display a time relative to how long ago it was. This component requires JavaScript.

## Examples

### auto

Default

<Example src="<time-ago datetime='2021-03-03T16:53:55Z' class='no-wrap '>Mar 3, 2021</time-ago>" />

```erb
<%= render(Primer::TimeAgoComponent.new(time: Time.zone.now)) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `time` | `Time` | N/A | The time to be formatted |
| `micro` | `Boolean` | `false` | If true then the text will be formatted in "micro" mode, using as few characters as possible |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
