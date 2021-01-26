---
title: Breadcrumb
status: Experimental
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use breadcrumbs to display page hierarchy within a section of the site. All of the items in the breadcrumb "trail" are links except for the final item, which is a plain string indicating the current page.

## Examples

### Basic

<iframe style="width: 100%; border: 0px; height: 40px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><nav aria-label='Breadcrumb'>  <ol>      <li class='breadcrumb-item  '><a href='/'>Home</a></li>      <li class='breadcrumb-item  '><a href='/about'>About</a></li>      <li aria-current='page' class='breadcrumb-item  '>Team</li>  </ol></nav></body></html>"></iframe>

```erb
<%= render(Primer::BreadcrumbComponent.new) do |component| %>
  <% component.slot(:item, href: "/") do %>Home<% end %>
  <% component.slot(:item, href: "/about") do %>About<% end %>
  <% component.slot(:item, selected: true) do %>Team<% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `item` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `href` | `String` | `nil` | The URL to link to. |
| `selected` | `Boolean` | `false` | Whether or not the item is selected and not rendered as a link. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

_Note: if both `href` and `selected: true` are passed in, `href` will be ignored and the item will not be rendered as a link._
