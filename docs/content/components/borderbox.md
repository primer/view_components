---
title: BorderBox
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/border_box_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

BorderBox is a Box component with a border.

## Examples

### Header, body, rows, and footer

<iframe onLoad={(e) => e.target.style.height = e.target.contentWindow.document.body.scrollHeight + 34 + 'px'} style="width: 100%; border: 0px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css-next@canary/dist/primer.css' rel='stylesheet'></head><body><div class='Box '>  <div class='Box-header '>    Header</div>  <div class='Box-body '>    Body</div>    <ul>        <li class='Box-row '>      Row one</li>        <li class='Box-row '>    Row two</li>    </ul>  <div class='Box-footer '>    Footer</div></div></body></html>"></iframe>

```erb
<%= render(Primer::BorderBoxComponent.new) do |component| %>
  <% component.header do %>
    Header
  <% end %>
  <% component.body do %>
    Body
  <% end %>
  <% component.row do %>
    <% if true %>
      Row one
    <% end %>
  <% end %>
  <% component.row do %>
    Row two
  <% end %>
  <% component.footer do %>
    Footer
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Header`

Optional Header.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Body`

Optional Body.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Footer`

Optional Footer.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Rows`

Use Rows to add rows with borders and maintain the same padding.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
