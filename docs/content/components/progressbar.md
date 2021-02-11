---
title: ProgressBar
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/progress_bar_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use ProgressBar to visualize task completion.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 44px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span class='Progress '>    <span style='width: 25%;' class='Progress-item bg-green'></span></span></body></html>"></iframe>

```erb
<%= render(Primer::ProgressBarComponent.new) do |component| %>
  <% component.slot(:item, percentage: 25) %>
<% end %>
```

### Small

<iframe style="width: 100%; border: 0px; height: 39px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span class='Progress Progress--small '>    <span style='width: 50%;' class='Progress-item bg-blue-4'></span></span></body></html>"></iframe>

```erb
<%= render(Primer::ProgressBarComponent.new(size: :small)) do |component| %>
  <% component.slot(:item, bg: :blue_4, percentage: 50) %>
<% end %>
```

### Large

<iframe style="width: 100%; border: 0px; height: 44px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span class='Progress Progress--large '>    <span style='width: 75%;' class='Progress-item bg-red-4'></span></span></body></html>"></iframe>

```erb
<%= render(Primer::ProgressBarComponent.new(size: :large)) do |component| %>
  <% component.slot(:item, bg: :red_4, percentage: 75) %>
<% end %>
```

### Multiple items

<iframe style="width: 100%; border: 0px; height: 44px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><span class='Progress '>    <span style='width: 10%;' class='Progress-item bg-green'></span>    <span style='width: 20%;' class='Progress-item bg-blue-4'></span>    <span style='width: 30%;' class='Progress-item bg-red-4'></span></span></body></html>"></iframe>

```erb
<%= render(Primer::ProgressBarComponent.new) do |component| %>
  <% component.slot(:item, percentage: 10) %>
  <% component.slot(:item, bg: :blue_4, percentage: 20) %>
  <% component.slot(:item, bg: :red_4, percentage: 30) %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `size` | `Symbol` | `:default` | One of `:default`, `:small`, or `:large`. Increases height. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `item` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `percentage` | `Integer` | `0` | Percentage completion of item. |
| `bg` | `Symbol` | `:green` | Color of item. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

:nodoc
