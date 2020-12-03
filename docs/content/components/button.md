---
title: Button
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Button types

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><button type='button' class='btn '>Default</button><button type='button' class='btn btn-primary '>Primary</button><button type='button' class='btn btn-danger '>Danger</button><button type='button' class='btn btn-outline '>Outline</button></body></html>"></iframe>

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(button_type: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(button_type: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(button_type: :outline)) { "Outline" } %>
```

### Variants

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><button type='button' class='btn btn-sm '>Small</button><button type='button' class='btn '>Medium</button><button type='button' class='btn btn-large '>Large</button></body></html>"></iframe>

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
