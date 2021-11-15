---
title: DropdownMenu
componentId: dropdown_menu
status: Deprecated
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_menu_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-dropdown-menu-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

DropdownMenus are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code)
of the select menu.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `direction` | `Symbol` | `:se` | One of `:e`, `:ne`, `:s`, `:se`, `:sw`, or `:w`. |
| `scheme` | `Symbol` | `:default` | Pass `:dark` for dark mode theming |
| `header` | `String` | `nil` | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### With a header

<Example src="<div>  <details data-view-component='true' class='details-overlay details-reset position-relative'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>      <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>          <ul>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>          <li><a class='dropdown-item' href='#url'>Dropdown item</a></li>        </ul></details-menu></div></details></div>" />

```erb
<div>
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
