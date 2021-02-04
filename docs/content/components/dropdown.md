---
title: Dropdown
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Dropdowns are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code) of the select menu.

## Examples

### Default

<iframe style="width: 100%; border: 0px; height: 210px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='margin-bottom: 150px'>  <details class='dropdown details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Dropdown</summary>  <div>    <details-menu role='menu' class='dropdown-menu dropdown-menu-se '>    <div class='dropdown-header'>      Options    </div>  <ul>      <li class='dropdown-item '>Item 1</li>      <li class='dropdown-item '>Item 2</li>      <li role='none' class='dropdown-divider '></li>      <li class='dropdown-item '>Item 3</li>      <li class='dropdown-item '>Item 4</li>  </ul></details-menu></div></details></div></body></html>"></iframe>

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

<iframe style="width: 100%; border: 0px; height: 210px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='margin-bottom: 150px' class='d-flex flex-justify-center'>  <details class='dropdown details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Dropdown</summary>  <div>    <details-menu role='menu' class='dropdown-menu dropdown-menu-s '>    <div class='dropdown-header'>      Options    </div>  <ul>      <li class='dropdown-item '>Item 1</li>      <li class='dropdown-item '>Item 2</li>      <li role='none' class='dropdown-divider '></li>      <li class='dropdown-item '>Item 3</li>      <li class='dropdown-item '>Item 4</li>  </ul></details-menu></div></details></div></body></html>"></iframe>

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
