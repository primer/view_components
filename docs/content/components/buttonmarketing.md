---
title: ButtonMarketing
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/marketing.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-marketing-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Schemes

<Example src="<button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-primary-mktg mr-2'>Primary</button><button type='button' class='btn-mktg btn-outline-mktg '>Outline</button><div class='color-bg-canvas-inverse'>  <button type='button' class='btn-mktg btn-transparent '>Transparent</button></div>" />

```erb
<%= render(Primer::Button::Marketing.new(mr: 2)) { "Default" } %>
<%= render(Primer::Button::Marketing.new(scheme: :primary, mr: 2)) { "Primary" } %>
<%= render(Primer::Button::Marketing.new(scheme: :outline)) { "Outline" } %>
<div class="color-bg-canvas-inverse">
  <%= render(Primer::Button::Marketing.new(scheme: :transparent)) { "Transparent" } %>
</div>
```

### Sizes

<Example src="<button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-large-mktg '>Large</button>" />

```erb
<%= render(Primer::Button::Marketing.new(mr: 2)) { "Default" } %>
<%= render(Primer::Button::Marketing.new(variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `scheme` | `Symbol` | `:default` | One of `:default`, `:primary`, `:outline`, or `:transparent`. |
| `variant` | `Symbol` | `:default` | One of `:default` and `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button` and `:a`. |
| `type` | `Symbol` | `:button` | One of `:button` and `:submit`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
