---
title: Dropdown
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Dropdowns are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code) of the select menu.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 244px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='margin-bottom: 150px'>  <details class='dropdown details-overlay details-reset position-relative'></details></div></body></html>"></iframe>

```erb
<div style="margin-bottom: 150px">
  <%= render(Primer::DropdownComponent.new) do |c| %>
    <% c.button do %>
      Dropdown
    <% end %>

    <%= c.menu(header: "Options") do |menu|
      menu.item { "Item 1" }
      menu.item { "Item 2" }
      menu.item(divider: true)
      menu.item { "Item 3" }
      menu.item { "Item 4" }
    end %>
  <% end %>
</div>
```

### With Direction

<iframe style="width: 100%; border: 0px; height: 244px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='margin-bottom: 150px' class='d-flex flex-justify-center'>  <details class='dropdown details-overlay details-reset position-relative'></details></div></body></html>"></iframe>

```erb
<div style="margin-bottom: 150px" class="d-flex flex-justify-center">
  <%= render(Primer::DropdownComponent.new) do |c| %>
    <% c.button do %>
      Dropdown
    <% end %>

    <%= c.menu(header: "Options", direction: :s) do |menu|
      menu.item { "Item 1" }
      menu.item { "Item 2" }
      menu.item(divider: true)
      menu.item { "Item 3" }
      menu.item { "Item 4" }
    end %>
  <% end %>
</div>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:default` | One of `:none`, `:default`, or `:dark`. |
| `reset` | `Boolean` | `true` | Whether to hide the default caret on the button |
| `summary_classes` | `String` | `""` | Custom classes to add to the button |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Button`

Required trigger for the dropdown. Only accepts a content.
Its classes can be customized by the `summary_classes` param in the parent component

### `Menu`

Required context menu for the dropdown

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `direction` | `Symbol` | N/A | One of `:se`, `:sw`, `:w`, `:e`, `:ne`, or `:s`. |
| `scheme` | `Symbol` | N/A | Pass :dark for dark mode theming |
| `header` | `String` | N/A | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
