---
title: DropdownMenu
status: Deprecated
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_menu_component.rb
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

DropdownMenus are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code)
of the select menu.

## Examples

### With a header

<iframe style="width: 100%; border: 0px; height: 234px;" srcdoc="<html class='Box height-full p-3'><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><div style='margin-bottom: 150px'>  <details class='details-overlay details-reset position-relative'></details></div></body></html>"></iframe>

```erb
<div style="margin-bottom: 150px">
  <%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
    <% c.summary do %>
      Dropdown
    <% end %>

    <% c.body do %>
      <%= render(Primer::DropdownMenuComponent.new(header: "Options")) do %>
        <ul>
          <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
          <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
          <li><a class="dropdown-item" href="#url">Dropdown item</a></li>
        </ul>
      <% end %>
    <% end %>
  <% end %>
</div>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `direction` | `Symbol` | `:se` | One of `:se`, `:sw`, `:w`, `:e`, `:ne`, or `:s`. |
| `scheme` | `Symbol` | `:default` | Pass :dark for dark mode theming |
| `header` | `String` | `nil` | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
