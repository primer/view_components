---
title: ButtonLink
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/link.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-link-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Button::Link to create a button that looks like a link.

## Examples

### Default

<Example src="<button type='button' class='btn-link '>Link</button>" />

```erb
<%= render(Primer::Button::Link.new) { "Link" } %>
```

### Block

<Example src="<button type='button' class='btn-link btn-block '>Block</button>" />

```erb
<%= render(Primer::Button::Link.new(block: :true)) { "Block" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | N/A | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | N/A | One of `:button`, `:reset`, or `:submit`. |
| `block` | `Boolean` | N/A | Whether button is full-width with `display: block`. |
