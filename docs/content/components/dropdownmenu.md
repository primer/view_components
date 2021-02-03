---
title: DropdownMenu
status: Experimental
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_menu_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

DropdownMenus are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code)
of the select menu.

## Examples

### With a header

<iframe style="width: 100%; border: 0px; height: 200px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div class='position-relative mt-2'>  <details-menu role='menu' class='dropdown-menu dropdown-menu-se '>    <div class='dropdown-header'>      Options    </div>  <ul>      <li class='dropdown-item '>Item 1</li>      <li class='dropdown-item '>Item 2</li>      <li role='none' class='dropdown-divider '></li>      <li class='dropdown-item '>Item 3</li>      <li class='dropdown-item '>Item 4</li>  </ul></details-menu></div></body></html>"></iframe>

```erb
<div class="position-relative mt-2">
  <%= render(Primer::DropdownMenuComponent.new(header: "Options")) do |c|
    c.item { "Item 1" }
    c.item { "Item 2" }
    c.item(divider: true)
    c.item { "Item 3" }
    c.item { "Item 4" }
  end %>
</div>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `direction` | `Symbol` | `:se` | One of `:se`, `:sw`, `:w`, `:e`, `:ne`, or `:s`. |
| `scheme` | `Symbol` | `:default` | Pass :dark for dark mode theming |
| `header` | `String` | `nil` | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
