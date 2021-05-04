---
title: LocalTime
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/local_time.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-local-time-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Examples

### Example goes here

<Example src="<local-time datetime='2014-06-01T13:05:07Z' weekday='short' year='numeric' month='short' day='numeric' hour='numeric' minute='numeric' second='numeric'>    June 1, 2014 13:05 +00:00</local-time>" />

```erb

<%= render(Primer::LocalTime.new(datetime: "2014-06-01T13:05:07Z")) %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
