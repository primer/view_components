---
title: Text
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/text_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-text-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

The Text component is a wrapper component that will apply typography styles to the text inside.

## Examples

### Default

<Example src="<p class='text-bold'>Bold Text</p><p class='color-red-5'>Red Text</p>" />

```erb
<%= render(Primer::TextComponent.new(tag: :p, font_weight: :bold)) { "Bold Text" } %>
<%= render(Primer::TextComponent.new(tag: :p, color: :red_5)) { "Red Text" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
