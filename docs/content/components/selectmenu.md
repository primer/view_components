---
title: SelectMenu
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use select menus to list clickable choices, allow filtering between them, and highlight
which ones are selected.

## Examples

### Using DetailsComponent

Use a `DetailsComponent` to toggle the select menu:

<iframe style="width: 100%; border: 0px; height: 630px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Choose an option</summary>    <div>      <div class='SelectMenu '>  <div class='SelectMenu-modal '>      <header class='SelectMenu-header '>        <h3 class='SelectMenu-title '>          My menu</h3></header>      <div class='SelectMenu-list '>                    <button role='menuitemcheckbox' aria-checked='true' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 1</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 2</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 3</button></div></div></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative) do |details_component| %>
  <% details_component.slot(:summary) do %>
    Choose an option
  <% end %>
  <% details_component.slot(:body) do %>
    <%= render Primer::SelectMenuComponent.new do |menu_component| %>
      <%= menu_component.slot(:header) do %>
        My menu
      <% end %>
      <%= menu_component.slot(:item, selected: true, icon: "check") do %>
        Item 1
      <% end %>
      <%= menu_component.slot(:item, icon: "check") do %>
        Item 2
      <% end %>
      <%= menu_component.slot(:item, icon: "check") do %>
        Item 3
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |

### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |

### `item` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |

### `tab` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |

### `filter` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |

### `footer` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
