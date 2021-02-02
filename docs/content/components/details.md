---
title: Details
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/details_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Details classes are created to enhance the native behaviors of the details element

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 100px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.slot(:summary) do %>
    Click me
  <% end %>

  <% c.slot(:body) do %>
    Body
  <% end %>
<% end %>
```

### Custom button

<iframe style="width: 100%; border: 0px; height: 100px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn btn-primary btn-sm '>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.slot(:summary, variant: :small, button_type: :primary) do %>
    Click me
  <% end %>

  <% c.slot(:body) do %>
    Body
  <% end %>
<% end %>
```

### Without button

<iframe style="width: 100%; border: 0px; height: 100px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button'>    Click me</summary>  <div>    Body</div></details></body></html>"></iframe>

```erb
<%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
  <% c.slot(:summary, button: false) do %>
    Click me
  <% end %>

  <% c.slot(:body) do %>
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

### `body` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `summary` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `button` | `Boolean` | `true` | If there should be a button or not |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
