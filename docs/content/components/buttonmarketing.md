---
title: ButtonMarketing
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_marketing_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Button types

<iframe style="width: 100%; border: 0px; height: 125px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-primary-mktg mr-2'>Primary</button><button type='button' class='btn-mktg btn-outline-mktg '>Outline</button><div class='bg-gray-dark'>  <button type='button' class='btn-mktg btn-transparent '>Transparent</button></div></body></html>"></iframe>

```erb
<%= render(Primer::ButtonMarketingComponent.new(mr: 2)) { "Default" } %>
<%= render(Primer::ButtonMarketingComponent.new(button_type: :primary, mr: 2)) { "Primary" } %>
<%= render(Primer::ButtonMarketingComponent.new(button_type: :outline)) { "Outline" } %>
<div class="bg-gray-dark">
  <%= render(Primer::ButtonMarketingComponent.new(button_type: :transparent)) { "Transparent" } %>
</div>
```

### Sizes

<iframe style="width: 100%; border: 0px; height: 75px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><button type='button' class='btn-mktg mr-2'>Default</button><button type='button' class='btn-mktg btn-large-mktg '>Large</button></body></html>"></iframe>

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
