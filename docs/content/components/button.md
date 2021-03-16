---
title: Button
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Button types

<Example src="<button type='button' class='btn '>Default</button><button type='button' class='btn btn-primary '>Primary</button><button type='button' class='btn btn-danger '>Danger</button><button type='button' class='btn btn-outline '>Outline</button><button type='button' class='btn btn-invisible '>Invisible</button><button type='button' class='btn btn-block '>Block</button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonPrimaryComponent.new) { "Primary" } %>
<%= render(Primer::ButtonDangerComponent.new) { "Danger" } %>
<%= render(Primer::ButtonOutlineComponent.new) { "Outline" } %>
<%= render(Primer::ButtonInvisibleComponent.new) { "Invisible" } %>
<%= render(Primer::ButtonBlockComponent.new) { "Block" } %>
```

### Variants

<Example src="<button type='button' class='btn btn-sm '>Small</button><button type='button' class='btn '>Medium</button><button type='button' class='btn btn-large '>Large</button>" />

```erb
<%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
<%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
<%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `variant` | `Symbol` | `:medium` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
