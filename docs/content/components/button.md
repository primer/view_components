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

<Example src="<button type='button' class='btn '>Default</button><button type='button' class='btn-primary btn '>Primary</button><button type='button' class='btn-danger btn '>Danger</button><button type='button' class='btn-outline btn '>Outline</button><button type='button' class='btn-invisible btn '>Invisible</button><button type='button' class='btn-link '>Link</button><button type='button' class='btn-block btn '>Block</button>" />

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(scheme: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(scheme: :outline)) { "Outline" } %>
<%= render(Primer::ButtonComponent.new(scheme: :invisible)) { "Invisible" } %>
<%= render(Primer::ButtonComponent.new(scheme: :link)) { "Link" } %>
<%= render(Primer::ButtonComponent.new(scheme: :block)) { "Block" } %>
```

### Variants

<Example src="<button type='button' class='btn-sm btn '>Small</button><button type='button' class='btn '>Medium</button><button type='button' class='btn-large btn '>Large</button>" />

```erb
<%= render(Primer::ButtonComponent.new(variant: :small)) { "Small" } %>
<%= render(Primer::ButtonComponent.new(variant: :medium)) { "Medium" } %>
<%= render(Primer::ButtonComponent.new(variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:primary`, `:danger`, `:outline`, `:block`, `:invisible`, or `:link`. |
| `variant` | `Symbol` | `:medium` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
