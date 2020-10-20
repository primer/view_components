---
title: Subhead
---

Use the Subhead component for page headings.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 95px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Subhead hx_Subhead--responsive '>    <div class='Subhead-heading '>      My Heading</div>    <div class='Subhead-description '>      My Description</div></div></body></html>"></iframe>

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.slot(:heading) do %>
    My Heading
  <% end %>
  <% component.slot(:description) do %>
    My Description
  <% end %>
<% end %>
```

### Without border

<iframe style="width: 100%; border: 0px; height: 95px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Subhead hx_Subhead--responsive border-bottom-0 mb-0'>    <div class='Subhead-heading '>      My Heading</div>    <div class='Subhead-description '>      My Description</div></div></body></html>"></iframe>

```erb
<%= render(Primer::SubheadComponent.new(hide_border: true)) do |component| %>
  <% component.slot(:heading) do %>
    My Heading
  <% end %>
  <% component.slot(:description) do %>
    My Description
  <% end %>
<% end %>
```

### With actions

<iframe style="width: 100%; border: 0px; height: 95px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Subhead hx_Subhead--responsive '>    <div class='Subhead-heading '>      My Heading</div>    <div class='Subhead-actions '>      <a href='http://www.google.com' role='button' class='btn btn-danger '>Action</a></div>    <div class='Subhead-description '>      My Description</div></div></body></html>"></iframe>

```erb
<%= render(Primer::SubheadComponent.new) do |component| %>
  <% component.slot(:heading) do %>
    My Heading
  <% end %>
  <% component.slot(:description) do %>
    My Description
  <% end %>
  <% component.slot(:actions) do %>
    <%= render(
      Primer::ButtonComponent.new(
        tag: :a, href: "http://www.google.com", button_type: :danger
      )
    ) { "Action" } %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `spacious` | `Boolean` | `false` | Whether to add spacing to the Subhead. |
| `hide_border` | `Boolean` | `false` | Whether to hide the border under the heading. |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |

### `heading` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `danger` | `Boolean` | `false` | Whether to style the heading as dangerous. |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |

### `actions` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |

### `description` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |
