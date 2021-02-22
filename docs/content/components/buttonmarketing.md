---
title: ButtonMarketing
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_marketing_component.rb
storybook: https://primer-view-components.herokuapp.com/?path=/story/primer-button-marketing-component
---

import IFrame from '../../src/@primer/gatsby-theme-doctocat/components/iframe'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Button types

<IFrame height="auto" content="<button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-primary-mktg mr-2'>Primary</button><button type='button' class='btn-mktg btn-outline-mktg '>Outline</button><div class='bg-gray-dark'>  <button type='button' class='btn-mktg btn-transparent '>Transparent</button></div>"></IFrame>

```erb
<%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
<%= render(Primer::ButtonMarketingComponent.new(button_type: :primary, mr: 2)) { "Primary" } %>
<%= render(Primer::ButtonMarketingComponent.new(button_type: :outline)) { "Outline" } %>
<div class="bg-gray-dark">
  <%= render(Primer::ButtonMarketingComponent.new(button_type: :transparent)) { "Transparent" } %>
</div>
```

### Sizes

<IFrame height="auto" content="<button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-large-mktg '>Large</button>"></IFrame>

```erb
<%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
<%= render(Primer::ButtonMarketingComponent.new(variant: :large)) { "Large" } %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `button_type` | `Symbol` | `:default` | One of `:default`, `:primary`, `:outline`, or `:transparent`. |
| `variant` | `Symbol` | `:default` | One of `:default` and `:large`. |
| `tag` | `Symbol` | `:button` | One of `:button` and `:a`. |
| `type` | `Symbol` | `:button` | One of `:button` and `:submit`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
