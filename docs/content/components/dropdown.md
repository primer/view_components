---
title: Dropdown
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-dropdown-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Dropdowns are lightweight context menus for housing navigation and actions.
They're great for instances where you don't need the full power (and code) of the select menu.

## Examples

### Default

<Example src="<div>  <details class='dropdown details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Dropdown</summary>  <div>    <details-menu role='menu' class='dropdown-menu dropdown-menu-se '>    <div class='dropdown-header'>      Options    </div>  <ul>      <li class='dropdown-item '>Item 1</li>      <li class='dropdown-item '>Item 2</li>      <li role='none' class='dropdown-divider '></li>      <li class='dropdown-item '>Item 3</li>      <li class='dropdown-item '>Item 4</li>  </ul></details-menu></div></details></div>" />

```erb
<div>
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

<Example src="<div>  <details class='dropdown details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Dropdown</summary>  <div>    <details-menu role='menu' class='dropdown-menu dropdown-menu-s '>    <div class='dropdown-header'>      Options    </div>  <ul>      <li class='dropdown-item '>Item 1</li>      <li class='dropdown-item '>Item 2</li>      <li role='none' class='dropdown-divider '></li>      <li class='dropdown-item '>Item 3</li>      <li class='dropdown-item '>Item 4</li>  </ul></details-menu></div></details></div>" />

```erb
<div>
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
