---
title: Popover
---

Popovers are used to bring attention to specific user interface elements, typically to suggest an action or to guide users through a new experience.

By default, the popover renders with absolute positioning, meaning it should usually be wrapped in an element with a relative position in order to be positioned properly. To render the popover with relative positioning, use the relative property.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 150px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Popover position-relative right-0 left-0'>  <div class='Popover-message Box p-4 mt-2 mx-auto text-left box-shadow-large'>      <h4 class='mb-2'>        Activity feed</h4>    This is the Popover body.</div></div></body></html>"></iframe>

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.slot(:heading) do %>
    Activity feed
  <% end %>
  <% component.slot(:body) do %>
    This is the Popover body.
  <% end %>
<% end %>
```

### Large

<iframe style="width: 100%; border: 0px; height: 150px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Popover position-relative right-0 left-0'>  <div class='Popover-message Box Popover-message--large p-4 mt-2 mx-auto text-left box-shadow-large'>      <h4 class='mb-2'>        Activity feed</h4>    This is the large Popover body.</div></div></body></html>"></iframe>

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.slot(:heading) do %>
    Activity feed
  <% end %>
  <% component.slot(:body, large: true) do %>
    This is the large Popover body.
  <% end %>
<% end %>
```

### Caret position

<iframe style="width: 100%; border: 0px; height: 150px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='Popover position-relative right-0 left-0'>  <div class='Popover-message Box Popover-message--left p-4 mt-2 mx-auto text-left box-shadow-large'>      <h4 class='mb-2'>        Activity feed</h4>    This is the large Popover body.</div></div></body></html>"></iframe>

```erb
<%= render Primer::PopoverComponent.new do |component| %>
  <% component.slot(:heading) do %>
    Activity feed
  <% end %>
  <% component.slot(:body, caret: :left) do %>
    This is the large Popover body.
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |

### `heading` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |

### `body` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `caret` | `Symbol` | `CARET_DEFAULT` | One of `:top`, `:bottom`, `:bottom_right`, `:bottom_left`, `:left`, `:left_bottom`, `:left_top`, `:right`, `:right_bottom`, `:right_top`, `:top_left`, or `:top_right`. |
| `large` | `Boolean` | `false` | Whather to use the large version of the component. |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |
