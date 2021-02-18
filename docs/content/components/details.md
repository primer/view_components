---
title: Details
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use DetailsComponent to reveal content after clicking a button.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.summary do %>
    Click me
  <% end %>

  <% c.body do %>
    Body
  <% end %>
<% end %>
```

### Custom button

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.summary(variant: :small, button_type: :primary) do %>
    Click me
  <% end %>

  <% c.body do %>
    Body
  <% end %>
<% end %>
```

### Without button

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.summary(button: false) do %>
    Click me
  <% end %>

  <% c.body do %>
    Body
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:none` | Dictates the type of overlay to render with. One of `:none`, `:default`, or `:dark`. |
| `reset` | `Boolean` | `false` | Defatuls to false. If set to true, it will remove the default caret and remove style from the summary element |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Body`

### `Summary`
