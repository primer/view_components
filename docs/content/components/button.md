---
title: Primer::ButtonComponent
---

Use buttons for actions (e.g. in forms). Use links for destinations, or moving from one page to another.

## Examples

### Button types

<iframe style="width: 100%; border: 0px; height: 50px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><button type='button' class='btn '>Default</button><button type='button' class='btn btn-primary '>Primary</button><button type='button' class='btn btn-danger '>Danger</button><button type='button' class='btn btn-outline '>Danger</button></body></html>"></iframe>

```erb
<%= render(Primer::ButtonComponent.new) { "Default" } %>
<%= render(Primer::ButtonComponent.new(button_type: :primary)) { "Primary" } %>
<%= render(Primer::ButtonComponent.new(button_type: :danger)) { "Danger" } %>
<%= render(Primer::ButtonComponent.new(button_type: :outline)) { "Danger" } %>
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
| `button_type` | `Symbol` | `DEFAULT_BUTTON_TYPE` | One of `:default`, `:primary`, `:danger`, or `:outline`. |
| `variant` | `Symbol` | `DEFAULT_VARIANT` | One of `:small`, `:medium`, or `:large`. |
| `tag` | `Symbol` | `DEFAULT_TAG` | One of `:button`, `:a`, or `:summary`. |
| `type` | `Symbol` | `DEFAULT_TYPE` | One of `:button`, `:reset`, or `:submit`. |
| `group_item` | `Boolean` | `false` | Whether button is part of a ButtonGroup. |
