---
title: Box
status: Stable
source: https://github.com/primer/view_components/tree/main/app/components/primer/box_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-box-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

A basic wrapper component for most layout related needs.

## Examples

### Default

<Example src="<div>Your content here</div>" />

```erb
<%= render(Primer::BoxComponent.new) { "Your content here" } %>
```

### Color and padding

<Example src="<div class='color-bg-tertiary p-3'>Hello world</div>" />

```erb
<%= render(Primer::BoxComponent.new(bg: :tertiary, p: 3)) { "Hello world" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
