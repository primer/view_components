---
title: Button
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Schemes

<Example src="<button type='button' class='btn '>Default</button><button type='button' class='btn btn-primary '>Primary</button><button type='button' class='btn btn-danger '>Danger</button><button type='button' class='btn btn-outline '>Outline</button><button type='button' class='btn btn-invisible '>Invisible</button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(scheme: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(scheme: :outline)) { "Outline" } %>
<%= render(Primer::ButtonComponent.new(scheme: :invisible)) { "Invisible" } %>
```

### Variants

<Example src="<button type='button' class='btn btn-sm '>Small</button><button type='button' class='btn '>Medium</button><button type='button' class='btn btn-large '>Large</button>" />

```erb
<%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
<%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
<%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
```

### Block

<Example src="<button type='button' class='btn btn-block '>Block</button><button type='button' class='btn btn-primary btn-block '>Primary block</button>" />

```erb
<%= render(Primer::ButtonComponent.new(block: :true)) { "Block" } %>
<%= render(Primer::ButtonComponent.new(block: :true, scheme: :primary)) { "Primary block" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:primary`, `:danger`, `:outline`, or `:invisible`. |
| `variant` | `Symbol` | N/A | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | N/A | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | N/A | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | N/A | Whether button is part of a ButtonGroup. |
| `block` | `Boolean` | N/A | Whether button is full-width with `display: block`. |
