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

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `id` | `String` | N/A | unique id |
| `type` | `Symbol` | N/A | type of tooltip |
| `text` | `String` | N/A | the text to appear in the tooltip |
| `direction` | `String` | N/A | Direction of the tooltip. One of `:e`, `:n`, `:ne`, `:nw`, `:s`, `:se`, `:sw`, or `:w`. |
| `align` | `String` | N/A | Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. One of `:default`, `:left_1`, `:left_2`, `:right_1`, or `:right_2`. |
| `multiline` | `Boolean` | N/A | Use this when you have long content |
| `no_delay` | `Boolean` | N/A | By default the tooltips have a slight delay before appearing. Set true to override this |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div class='pt-5'>  <tooltip-container tabindex='0' data-view-component='true' class='alpha-tooltipped-container'>  <span aria-describedby='unique-tooltip' id='unique' tabindex='0' data-view-component='true'>    Default Bold Text</span>  <p hidden='hidden' id='unique-tooltip' role='tooltip' data-view-component='true' class='alpha-tooltipped'>this is tooltip text</p></tooltip-container></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::Alpha::Tooltip.new(id: "unique", type: :describe, text: "this is tooltip text", tabindex: 0)) { "Default Bold Text" } %>
</div>
```

### with icon

<Example src="<tooltip-container data-view-component='true' class='alpha-tooltipped-container'>  <span aria-labelledby='unique-tooltip' id='unique' tabindex='0' data-view-component='true'>      <svg tabindex='0' aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-copy'>    <path fill-rule='evenodd' d='M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z'></path><path fill-rule='evenodd' d='M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.75-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z'></path></svg></span>  <p hidden='hidden' id='unique-tooltip' role='tooltip' data-view-component='true' class='alpha-tooltipped'>this is the best</p></tooltip-container>" />

```erb
<%= render(Primer::Alpha::Tooltip.new(id: "unique", type: :label, text: "this is the best"))  do %>
  <%= render Primer::OcticonComponent.new(:copy, tabindex: 0) %>
<% end %>
```
