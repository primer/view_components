---
title: Tooltip
componentId: tooltip
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/tooltip.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-tooltip
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Tooltip` is a wrapper component that will apply a tooltip to the provided content.

The element that triggers the tooltip must be rendered through the `trigger` slot.
If the trigger element is a view component, use the `trigger_component` slot.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `id` | `String` | N/A | unique tooltip id |
| `type` | `Symbol` | N/A | One of `:describe` and `:label`.. `:describe` indicates the tooltip provides supplementary information, while `:label` indicates the tooltip provides an accessible label. |
| `text` | `String` | N/A | the text to appear in the tooltip |
| `direction` | `String` | `:n` | Direction of the tooltip. One of `:e`, `:n`, `:n`, `:ne`, `:nw`, `:s`, `:se`, `:sw`, or `:w`. |
| `align` | `String` | N/A | Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. One of `:default`, `:left_1`, `:left_2`, `:right_1`, or `:right_2`. |
| `multiline` | `Boolean` | `false` | Use this when you have long content |
| `tooltip_arguments` | `Hash` | `{}` | System arguments for the tooltip element |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Trigger`

The element that triggers the tooltip

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | N/A | One of `:a`, `:button`, `:md-bold`, `:md-code`, `:md-header`, `:md-italic`, `:md-link`, `:md-ordered-list`, `:md-quote`, `:md-task-list`, `:md-unordered-list`, or `:summary`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Trigger_component`

The component that triggers the tooltip

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `klass` | `Class` | N/A | View component that triggers the tooltip. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### north direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-1' data-view-component='true'>GitHub</a>    <p id='unique-1' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-n'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-1", type: :describe, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### south direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <button aria-describedby='unique-2' data-view-component='true'>GitHub</button>    <p id='unique-2' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-s'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-2", type: :describe, direction: :s, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :button) { "GitHub"} %>
<% end %>
```

### east direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-3' data-view-component='true'>GitHub</a>    <p id='unique-3' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-e'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-3", type: :describe, direction: :e, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### west direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-4' data-view-component='true'>GitHub</a>    <p id='unique-4' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-w'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-4", type: :describe, direction: :w, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### northeast direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-5' data-view-component='true'>GitHub</a>    <p id='unique-5' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-ne'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-5", type: :describe, direction: :ne, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### southeast direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-6' data-view-component='true'>GitHub</a>    <p id='unique-6' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-se'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-6", type: :describe, direction: :se, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### northwest direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-7' data-view-component='true'>GitHub</a>    <p id='unique-7' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-nw'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-7", type: :describe, direction: :nw, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### southwest direction

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-8' data-view-component='true'>GitHub</a>    <p id='unique-8' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-sw'>An awesome place for developers</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-8", type: :describe, direction: :sw, text: "An awesome place for developers"))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### multiple lines

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>  <a aria-describedby='unique-9' data-view-component='true'>GitHub</a>    <p id='unique-9' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-n hx-tooltip-multiline'>This is the tooltip with multiple lines. This is the tooltip with multiple lines.</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-9", type: :describe, direction: :n, multiline: true, text: "This is the tooltip with multiple lines. This is the tooltip with multiple lines."))  do |component| %>
  <% component.trigger(tag: :a) { "GitHub"} %>
<% end %>
```

### tooltip on view component

<Example src="<tooltip-container data-view-component='true' class='hx-tooltip-container'>    <button aria-labelledby='unique-10' type='button' data-view-component='true' class='btn-octicon Box-btn-octicon'><svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-pencil'>    <path fill-rule='evenodd' d='M11.013 1.427a1.75 1.75 0 012.474 0l1.086 1.086a1.75 1.75 0 010 2.474l-8.61 8.61c-.21.21-.47.364-.756.445l-3.251.93a.75.75 0 01-.927-.928l.929-3.25a1.75 1.75 0 01.445-.758l8.61-8.61zm1.414 1.06a.25.25 0 00-.354 0L10.811 3.75l1.439 1.44 1.263-1.263a.25.25 0 000-.354l-1.086-1.086zM11.189 6.25L9.75 4.81l-6.286 6.287a.25.25 0 00-.064.108l-.558 1.953 1.953-.558a.249.249 0 00.108-.064l6.286-6.286z'></path></svg></button>  <p id='unique-10' role='tooltip' aria-hidden='true' hidden='hidden' data-view-component='true' class='hx-tooltip hx-tooltip-n'>Edit</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique-10", type: :label, text: "Edit"))  do |component| %>
  <% component.trigger_component(klass: Primer::IconButton, icon: :pencil, box: true) %>
<% end %>
```
