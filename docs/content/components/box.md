---
title: Box
status: Stable
source: https://github.com/primer/view_components/tree/main/app/components/primer/box_component.rb
storybook: https://primer-view-components.herokuapp.com/?path=/story/primer-box-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

A basic wrapper component for most layout related needs.

## Examples

### Default

<IFrame height="auto" content="<div>Your content here</div>"></IFrame>

```erb
<%= render(Primer::BoxComponent.new) { "Your content here" } %>
```

### Color and padding

<IFrame height="auto" content="<div class='bg-gray p-3'>Hello world</div>"></IFrame>

```erb
<%= render(Primer::BoxComponent.new(bg: :gray, p: 3)) { "Hello world" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
