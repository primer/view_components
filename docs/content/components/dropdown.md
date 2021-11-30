---
title: Dropdown
componentId: dropdown
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-dropdown
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Dropdown` is a lightweight context menu for housing navigation and actions.
They're great for instances where you don't need the full power (and code) of the SelectMenu.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `overlay` | `Symbol` | `:default` | One of `:dark`, `:default`, or `:none`. |
| `with_caret` | `Boolean` | `false` | Whether or not a caret should be rendered in the button. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Button`

Required trigger for the dropdown. Has the same arguments as [Button](/components/button),
but it is locked as a `summary` tag.

### `Menu`

Required context menu for the dropdown.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `as` | `Symbol` | N/A | When `as` is `:list`, wraps the menu in a `<ul>` with a `<li>` for each item. |
| `direction` | `Symbol` | N/A | One of `:e`, `:ne`, `:s`, `:se`, `:sw`, or `:w`. |
| `scheme` | `Symbol` | N/A | Pass `:dark` for dark mode theming |
| `header` | `String` | N/A | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options") do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item { "Item 3" }
  end %>
<% end %>
```

### With dividers

Dividers can be used to separate a group of items. They don't have any content.

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>      <a role='separator' data-view-component='true' class='dropdown-divider'></a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 4</a>      <a role='separator' data-view-component='true' class='dropdown-divider'></a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 5</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 6</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options") do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item(divider: true)
    menu.item { "Item 3" }
    menu.item { "Item 4" }
    menu.item(divider: true)
    menu.item { "Item 5" }
    menu.item { "Item 6" }
  end %>
<% end %>
```

### With direction

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset d-inline-block'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-s'>    <div class='dropdown-header'>      Options    </div>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 4</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new(display: :inline_block)) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options", direction: :s) do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item { "Item 3" }
    menu.item { "Item 4" }
  end %>
<% end %>
```

### With caret

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown<svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-triangle-down mr-n1'>    <path d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z'></path></svg></summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 4</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new(with_caret: true)) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options") do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item { "Item 3" }
    menu.item { "Item 4" }
  end %>
<% end %>
```

### Customizing the button

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn-primary btn-sm btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 4</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new) do |c| %>
  <% c.button(scheme: :primary, variant: :small) do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options") do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item { "Item 3" }
    menu.item { "Item 4" }
  end %>
<% end %>
```

### Menu as list

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>    <ul>          <li>            <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 1</a>          </li>          <li>            <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 2</a>          </li>          <li role='separator' data-view-component='true' class='dropdown-divider'></li>          <li>            <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a>          </li>          <li>            <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 4</a>          </li>    </ul></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(as: :list, header: "Options") do |menu|
    menu.item { "Item 1" }
    menu.item { "Item 2" }
    menu.item(divider: true)
    menu.item { "Item 3" }
    menu.item { "Item 4" }
  end %>
<% end %>
```

### Customizing menu items

<Example src="<details data-view-component='true' class='dropdown details-overlay details-reset'>  <summary role='button' data-view-component='true' class='btn'>  Dropdown</summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>      <button role='menuitem' type='button' data-view-component='true' class='dropdown-item btn-link'>  Item 1</button>      <a role='menuitem' data-view-component='true' class='custom-class dropdown-item'>Item 2</a>      <a role='menuitem' data-view-component='true' class='dropdown-item'>Item 3</a></details-menu></div></details>" />

```erb
<%= render(Primer::Dropdown.new) do |c| %>
  <% c.button do %>
    Dropdown
  <% end %>

  <% c.menu(header: "Options") do |menu|
    menu.item(tag: :button) { "Item 1" }
    menu.item(classes: "custom-class") { "Item 2" }
    menu.item { "Item 3" }
  end %>
<% end %>
```
