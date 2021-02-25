---
title: Heading
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/heading_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-heading-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use the Heading component to wrap a component that will create a heading element

## Examples

### Default

<Example src="<h1>H1 Text</h1><h2>H2 Text</h2><h3>H3 Text</h3>" />

```erb
<%= render(Primer::HeadingComponent.new) { "H1 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h2)) { "H2 Text" } %>
<%= render(Primer::HeadingComponent.new(tag: :h3)) { "H3 Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
