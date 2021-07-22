---
title: BaseButton
componentId: base_button
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/base_button.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-base-button
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `BaseButton` to render an unstyled `<button>` tag that can be customized.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `tag` | `Symbol` | `:button` | One of `:a`, `:button`, or `:summary`. |
| `type` | `Symbol` | `:button` | One of `:button`, `:reset`, or `:submit`. |
| `block` | `Boolean` | `false` | Whether button is full-width with `display: block`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Block

<Example src="<button type='button' data-view-component='true' class='btn-block'>Block</button><button scheme='primary' type='button' data-view-component='true' class='btn-block'>Primary block</button>" />

```erb
<%= render(Primer::BaseButton.new(block: :true)) { "Block" } %>
<%= render(Primer::BaseButton.new(block: :true, scheme: :primary)) { "Primary block" } %>
```
