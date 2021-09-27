---
title: SideNav
componentId: side_nav
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/alpha/side_nav.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-alpha-side-nav
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `bordered` | `Boolean` | `true` | Whether or not to render a bordered version of the component. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Items`

## Examples

### Example goes here

<Example src="<nav data-view-component='true' class='SideNav border rounded-2'></nav>" />

```erb

<%= render(Primer::Alpha::SideNav.new) { "Example" } %>
```
