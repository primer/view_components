---
title: Layout
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/layout.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-layout-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Add a general description of component here
Add additional usage considerations or best practices that may aid the user to use the component correctly.

## Accessibility

Add any accessibility considerations

## Examples

### Using containers

<Example src="  <div data-view-component='true'>    Example</div><div data-view-component='true' class='container-xl'>  <div data-view-component='true'>    Example</div></div><div data-view-component='true' class='container-lg'>  <div data-view-component='true'>    Example</div></div><div data-view-component='true' class='container-md'>  <div data-view-component='true'>    Example</div></div>" />

```erb

<%= render(Primer::Layout.new(container: :full)) { "Example" } %>
<%= render(Primer::Layout.new(container: :xl)) { "Example" } %>
<%= render(Primer::Layout.new(container: :lg)) { "Example" } %>
<%= render(Primer::Layout.new(container: :md)) { "Example" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
