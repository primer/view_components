---
title: DropdownMenu
status: Deprecated
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_menu_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-dropdown-menu-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

DropdownMenus are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code)
of the select menu.

## Examples

### With a header

<Example src="<div>  <details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Dropdown</summary>  <div>    <details-menu role='menu' class='dropdown-menu dropdown-menu-se '>    <div class='dropdown-header'>      Options    </div>          <ul>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>        </ul></details-menu></div></details></div>" />

```erb
<div>
  <%= render(Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative)) do |c| %>
    <% c.slot(:summary) do %>
      Dropdown
    <% end %>

    <% c.slot(:body) do %>
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
