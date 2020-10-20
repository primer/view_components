---
title: Primer::FlashComponent
---

The Flash component informs users of successful or pending actions.

## Examples

### Variants

<iframe style="width: 100%; border: 0px; height: 280px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flash '>    This is a flash message!</div><div class='flash flash-warn '>    This is a warning flash message!</div><div class='flash flash-error '>    This is a danger flash message!</div><div class='flash flash-success '>    This is a success flash message!</div></body></html>"></iframe>

```erb
<%= render(Primer::FlashComponent.new) { "This is a flash message!" } %>
<%= render(Primer::FlashComponent.new(variant: :warning)) { "This is a warning flash message!" } %>
<%= render(Primer::FlashComponent.new(variant: :danger)) { "This is a danger flash message!" } %>
<%= render(Primer::FlashComponent.new(variant: :success)) { "This is a success flash message!" } %>
```

### Full width

<iframe style="width: 100%; border: 0px; height: 80px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flash flash-full '>    This is a full width flash message!</div></body></html>"></iframe>

```erb
<%= render(Primer::FlashComponent.new(full: true)) { "This is a full width flash message!" } %>
```

### Dismissible

<iframe style="width: 100%; border: 0px; height: 80px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flash '>    This is a dismissible flash message!    <button class='flash-close js-flash-close' type='button' aria-label='Close'>      <svg class='octicon octicon-x' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z'></path></svg>    </button></div></body></html>"></iframe>

```erb
<%= render(Primer::FlashComponent.new(dismissible: true)) { "This is a dismissible flash message!" } %>
```

### Icon

<iframe style="width: 100%; border: 0px; height: 80px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flash '>  <svg class='octicon octicon-people' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M5.5 3.5a2 2 0 100 4 2 2 0 000-4zM2 5.5a3.5 3.5 0 115.898 2.549 5.507 5.507 0 013.034 4.084.75.75 0 11-1.482.235 4.001 4.001 0 00-7.9 0 .75.75 0 01-1.482-.236A5.507 5.507 0 013.102 8.05 3.49 3.49 0 012 5.5zM11 4a.75.75 0 100 1.5 1.5 1.5 0 01.666 2.844.75.75 0 00-.416.672v.352a.75.75 0 00.574.73c1.2.289 2.162 1.2 2.522 2.372a.75.75 0 101.434-.44 5.01 5.01 0 00-2.56-3.012A3 3 0 0011 4z'></path></svg>  This is a flash message with an icon!</div></body></html>"></iframe>

```erb
<%= render(Primer::FlashComponent.new(icon: "people")) { "This is a flash message with an icon!" } %>
```

### With actions

<iframe style="width: 100%; border: 0px; height: 80px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='flash '>      This is a flash message with actions!    <div class='flash-action '>      <button type='button' class='btn btn-sm '>Take action</button></div></div></body></html>"></iframe>

```erb
<%= render(Primer::FlashComponent.new) do |component| %>
  This is a flash message with actions!
  <% component.slot(:actions) do %>
    <%= render(Primer::ButtonComponent.new(variant: :small)) { "Take action" } %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `full` | `Boolean` | `false` | Whether the component should take up the full width of the screen. |
| `spacious` | `Boolean` | `false` | Whether to add margin to the bottom of the component. |
| `dismissible` | `Boolean` | `false` | Whether the component can be dismissed with an X button. |
| `icon` | `String` | `nil` | Name of Octicon icon to use. |
| `variant` | `Symbol` | `DEFAULT_VARIANT` | One of `:default`, `:warning`, `:danger`, or `:success`. |
| `kwargs` | `Hash` | N/A | Style arguments to be passed to Primer::Classify |

### `actions` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | Primer [style arguments](https://github.com/primer/view_components#built-in-styling-arguments). |
