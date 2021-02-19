---
title: Details
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use DetailsComponent to reveal content after clicking a button.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

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

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn btn-primary btn-sm '>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

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

<iframe style="width: 100%; border: 0px; height: 134px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary button='false' role='button' type='button' class='btn '>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

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

### `Summary`

Use the Summary slot as a trigger to reveal the content.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |

### `Body`

Use the Body slot as the main content to be shown when triggered by the Summary.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [System arguments](/system-arguments). |
