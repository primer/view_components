---
title: ButtonBase
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/base.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-base-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use Button::Base to render an unstyles `<button>` tag that can be customized.

## Examples

### Variants

<Example src="<button type='button' class='btn-sm '>Small</button><button type='button'>Medium</button><button type='button' class='btn-large '>Large</button>" />

```erb
<%= render(Primer::Button::Base.new(variant: :small)) { "Small" } %>
<%= render(Primer::Button::Base.new(variant: :medium)) { "Medium" } %>
<%= render(Primer::Button::Base.new(variant: :large)) { "Large" } %>
```

### Block

<Example src="<button type='button' class='btn-block '>Block</button><button scheme='primary' type='button' class='btn-block '>Primary block</button>" />

```erb
<%= render(Primer::Button::Base.new(block: :true)) { "Block" } %>
<%= render(Primer::Button::Base.new(block: :true, scheme: :primary)) { "Primary block" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `variant` | `Symbol` | `:medium` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
| `block` | `Boolean` | `false` | Whether button is full-width with `display: block`. |
