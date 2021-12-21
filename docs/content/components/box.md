---
title: Box
componentId: box
status: Stable
source: https://github.com/primer/view_components/tree/main/app/components/primer/box_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-box-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Box` is a basic wrapper component for most layout related needs.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<div data-view-component='true'>Your content here</div>" />

```erb
<%= render(Primer::BoxComponent.new) { "Your content here" } %>
```

### Color and padding

<Example src="<div data-view-component='true' class='color-bg-subtle p-3'>Hello world</div>" />

```erb
<%= render(Primer::BoxComponent.new(bg: :subtle, p: 3)) { "Hello world" } %>
```
