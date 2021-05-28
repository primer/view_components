---
title: Dropdown
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/dropdown.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-dropdown-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

`Dropdown` is a lightweight context menu for housing navigation and actions.
They're great for instances where you don't need the full power (and code) of the select menu.

## Examples

### Default

<Example src="<div>  <details data-view-component='true' class='dropdown details-overlay details-reset position-relative'>  <summary role='button' data-view-component='true' class='btn'>              Dropdown  </summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-se'>    <div class='dropdown-header'>      Options    </div>  <ul>      <li data-view-component='true' class='dropdown-item'>Item 1</li>      <li data-view-component='true' class='dropdown-item'>Item 2</li>      <li role='none' data-view-component='true' class='dropdown-divider'></li>      <li data-view-component='true' class='dropdown-item'>Item 3</li>      <li data-view-component='true' class='dropdown-item'>Item 4</li>  </ul></details-menu></div></details></div>" />

```erb
<div>
  <%= render(Primer::Dropdown.new) do |c| %>
    <% c.summary do %>
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

<Example src="<div>  <details data-view-component='true' class='dropdown details-overlay details-reset position-relative'>  <summary role='button' data-view-component='true' class='btn'>              Dropdown  </summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-s'>    <div class='dropdown-header'>      Options    </div>  <ul>      <li data-view-component='true' class='dropdown-item'>Item 1</li>      <li data-view-component='true' class='dropdown-item'>Item 2</li>      <li role='none' data-view-component='true' class='dropdown-divider'></li>      <li data-view-component='true' class='dropdown-item'>Item 3</li>      <li data-view-component='true' class='dropdown-item'>Item 4</li>  </ul></details-menu></div></details></div>" />

```erb
<div>
  <%= render(Primer::Dropdown.new) do |c| %>
    <% c.summary do %>
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

### Customizing the button

<Example src="<div>  <details data-view-component='true' class='dropdown details-overlay details-reset position-relative'>  <summary role='button' data-view-component='true' class='btn-primary btn-sm btn'>              Dropdown  </summary>  <div data-view-component='true'>    <details-menu role='menu' data-view-component='true' class='dropdown-menu dropdown-menu-s'>    <div class='dropdown-header'>      Options    </div>  <ul>      <li data-view-component='true' class='dropdown-item'>Item 1</li>      <li data-view-component='true' class='dropdown-item'>Item 2</li>      <li role='none' data-view-component='true' class='dropdown-divider'></li>      <li data-view-component='true' class='dropdown-item'>Item 3</li>      <li data-view-component='true' class='dropdown-item'>Item 4</li>  </ul></details-menu></div></details></div>" />

```erb
<div>
  <%= render(Primer::Dropdown.new) do |c| %>
    <% c.summary(scheme: :primary, variant: :small) do %>
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
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Summary`

Required trigger for the dropdown. Has the same arguments as [Button](/components/button),
but it is locked as a `summary` tag.

### `Menu`

Required context menu for the dropdown

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `direction` | `Symbol` | N/A | One of `:se`, `:sw`, `:w`, `:e`, `:ne`, or `:s`. |
| `scheme` | `Symbol` | N/A | Pass `:dark` for dark mode theming |
| `header` | `String` | N/A | Optional string to display as the header |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
