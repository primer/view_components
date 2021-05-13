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

Use `LocalTime` to format a date and time in the user's preferred locale format. This component requires JavaScript.

## Examples

### Default

<Example src="<local-time datetime='2014-06-01T13:05:07+00:00' weekday='short' year='numeric' month='short' day='numeric' hour='numeric' minute='numeric' second='numeric' time-zone-name='short'>June 1, 2014 13:05 +00:00</local-time>" />

```erb
<%= render(Primer::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"))) %>
```

### All the options

<Example src="<local-time datetime='2014-06-01T13:05:07+00:00' weekday='long' year='2-digit' month='long' day='2-digit' hour='2-digit' minute='2-digit' second='2-digit' time-zone-name='long'>June 1, 2014 13:05 +00:00</local-time>" />

```erb
<%= render(Primer::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"), weekday: :long, year: :"2-digit", month: :long, day: :"2-digit", hour: :"2-digit", minute: :"2-digit", second: :"2-digit", time_zone_name: :long)) %>
```

### With initial content

<Example src="<local-time datetime='2014-06-01T13:05:07+00:00' weekday='short' year='numeric' month='short' day='numeric' hour='numeric' minute='numeric' second='numeric' time-zone-name='short'>June 1, 2014 13:05 +00:00</local-time>" />

```erb
<%= render(Primer::LocalTime.new(datetime: DateTime.parse("2014-06-01T13:05:07Z"))) do %>
  <!-- This content will be replaced once the component connects -->
  2014/06/01 13:05
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `datetime` | `DateTime` | N/A | The date to parse |
| `initial_text` | `String` | `nil` | Text to render before component is initialized |
| `weekday` | `Symbol` | `:short` | One of `:short` and `:long`. |
| `year` | `Symbol` | `:numeric` | One of `:numeric` and `:2-digit`. |
| `month` | `Symbol` | `:short` | One of `:short` and `:long`. |
| `day` | `Symbol` | `:numeric` | One of `:numeric` and `:2-digit`. |
| `hour` | `Symbol` | `:numeric` | One of `:numeric` and `:2-digit`. |
| `minute` | `Symbol` | `:numeric` | One of `:numeric` and `:2-digit`. |
| `second` | `Symbol` | `:numeric` | One of `:numeric` and `:2-digit`. |
| `time_zone_name` | `Symbol` | `:short` | One of `:short` and `:long`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
