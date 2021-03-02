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

<Example src="<button type='button' class='btn '>Default</button><button type='button' class='btn btn-primary '>Primary</button><button type='button' class='btn btn-danger '>Danger</button><button type='button' class='btn btn-outline '>Outline</button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(button_type: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(button_type: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(button_type: :outline)) { "Outline" } %>
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
| `button_type` | `Symbol` | `:default` | One of `:default`, `:primary`, `:danger`, or `:outline`. |
| `variant` | `Symbol` | `:medium` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
