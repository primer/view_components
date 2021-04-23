---
title: Tooltip
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/tooltip_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-tooltip-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Tooltip component is a wrapper component that will apply a tooltip to the provided content.

## Examples

### Default

<Example src="<div class='pt-5'>  <span aria-label='Even bolder' class='tooltipped tooltipped-n '>Default Bold Text</span></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::TooltipComponent.new(label: "Even bolder")) { "Default Bold Text" } %>
</div>
```

### Wrapping another component

<Example src="<div class='pt-5'>  <span aria-label='Even bolder' class='tooltipped tooltipped-n '>    <button type='button' class='btn '>  Bold Button  </button></span></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::TooltipComponent.new(label: "Even bolder")) do %>
    <%= render(Primer::ButtonComponent.new) { "Bold Button" } %>
  <% end %>
</div>
```

### With a direction

<Example src="<div class='pt-5'>  <span aria-label='Even bolder' class='tooltipped tooltipped-s '>Bold Text With a Direction</span></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s)) { "Bold Text With a Direction" } %>
</div>
```

### With an alignment

<Example src="<div class='pt-5'>  <span alignment='right_1' aria-label='Even bolder' class='tooltipped tooltipped-s '>Bold Text With an Alignment</span></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s, alignment: :right_1)) { "Bold Text With an Alignment" } %>
</div>
```

### Without a delay

<Example src="<div class='pt-5'>  <span aria-label='Even bolder' class='tooltipped tooltipped-s tooltipped-no-delay '>Bold Text without a delay</span></div>" />

```erb
<div class="pt-5">
  <%= render(Primer::TooltipComponent.new(label: "Even bolder", direction: :s, no_delay: true)) { "Bold Text without a delay" } %>
</div>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label` | `String` | N/A | the text to appear in the tooltip |
| `direction` | `String` | `:n` | Direction of the tooltip. One of `:n`, `:nw`, `:ne`, `:w`, `:e`, `:sw`, `:s`, or `:se`. |
| `align` | `String` | `:default` | Align tooltips to the left or right of an element, combined with a `direction` to specify north or south. One of `:default`, `:left_1`, `:right_1`, `:left_2`, or `:right_2`. |
| `multiline` | `Boolean` | `false` | Use this when you have long content |
| `no_delay` | `Boolean` | `false` | By default the tooltips have a slight delay before appearing. Set true to override this |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
