---
title: SelectMenu
---

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use select menus to list clickable choices, allow filtering between them, and highlight
which ones are selected.

## Examples

### Basic example

<iframe style="width: 100%; border: 0px; height: 193px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details>  <summary role='button' type='button' class='btn '>    Choose an option</summary>  <div class='SelectMenu '>    <div class='SelectMenu-modal '>        <header class='SelectMenu-header '>          <h3 class='SelectMenu-title '>            My menu</h3></header>      <div class='SelectMenu-list '>                    <button role='menuitemcheckbox' aria-checked='true' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 1</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 2</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 3</button></div></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new do |component| %>
  <%= component.slot(:summary) do %>
    Choose an option
  <% end %>
  <%= component.slot(:header) do %>
    My menu
  <% end %>
  <%= component.slot(:item, selected: true) do %>
    Item 1
  <% end %>
  <%= component.slot(:item) do %>
    Item 2
  <% end %>
  <%= component.slot(:item) do %>
    Item 3
  <% end %>
<% end %>
```

### Close button

Include a button to close the menu:

<iframe style="width: 100%; border: 0px; height: 193px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details>  <summary role='button' type='button' class='btn '>    Choose an option</summary>  <div class='SelectMenu '>    <div class='SelectMenu-modal '>        <header class='SelectMenu-header '>          <h3 class='SelectMenu-title '>            My menu</h3>            <button type='button' class='btn SelectMenu-closeButton '>              <svg class='octicon octicon-x' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z'></path></svg></button></header>      <div class='SelectMenu-list '>                    <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 1</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 2</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 3</button></div></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new do |component| %>
  <%= component.slot(:summary) do %>
    Choose an option
  <% end %>
  <%= component.slot(:header, closeable: true) do %>
    My menu
  <% end %>
  <%= component.slot(:item) do %>
    Item 1
  <% end %>
  <%= component.slot(:item) do %>
    Item 2
  <% end %>
  <%= component.slot(:item) do %>
    Item 3
  <% end %>
<% end %>
```

### Filter

If the list is expected to get long, consider adding a filter input. On mobile devices it will add a fixed height and anchor the select menu to the top of the screen. This makes sure the filter input stays at the same position while typing.

<iframe style="width: 100%; border: 0px; height: 242px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details>  <summary role='button' type='button' class='btn '>    Choose an option</summary>  <div class='SelectMenu SelectMenu--hasFilter '>    <div class='SelectMenu-modal '>        <header class='SelectMenu-header '>          <h3 class='SelectMenu-title '>            My menu</h3></header>        <form class='SelectMenu-filter '>          <input type='text' placeholder='Filter' aria-label='Filter' class='SelectMenu-input form-control '></input>          </form>      <div class='SelectMenu-list '>                    <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 1</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 2</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 3</button></div></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new do |component| %>
  <%= component.slot(:summary) do %>
    Choose an option
  <% end %>
  <%= component.slot(:header) do %>
    My menu
  <% end %>
  <%= component.slot(:filter) %>
  <%= component.slot(:item) do %>
    Item 1
  <% end %>
  <%= component.slot(:item) do %>
    Item 2
  <% end %>
  <%= component.slot(:item) do %>
    Item 3
  <% end %>
<% end %>
```

### Blankslate

Sometimes a select menu needs to communicate a "blank slate" where there's no content in the menu's list.

<iframe style="width: 100%; border: 0px; height: 155px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details>  <summary title='Pick an item' role='button' type='button' class='btn '>    Choose an option    <span class='dropdown-caret'></span></summary>  <div class='SelectMenu '>    <div class='SelectMenu-modal '>      <div class='SelectMenu-list '>          <div class='SelectMenu-blankslate'>                <h4>No results</h4>  <p>There are no results to show.</p>          </div></div></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new(blankslate: true) do |component| %>
  <%= component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <h4>No results</h4>
  <p>There are no results to show.</p>
<% end %>
```

### Loading

When fetching large lists, consider showing a loading message.

<iframe style="width: 100%; border: 0px; height: 136px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details>  <summary title='Pick an item' role='button' type='button' class='btn '>    Choose an option    <span class='dropdown-caret'></span></summary>  <div class='SelectMenu '>    <div class='SelectMenu-modal '>      <div class='SelectMenu-list '>          <div class='SelectMenu-loading'>                      </div></div>        <footer class='SelectMenu-footer '>          Loading...</footer></div></div></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new(loading: true) do |component| %>
  <%= component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <%= component.slot(:footer) do %>
    Loading...
  <% end %>
<% end %>
```

### details-menu example

Use a details-menu instead of a div for the `.SelectMenu` element.

<iframe style="width: 100%; border: 0px; height: 193px;" srcdoc="<html><head><link href='https://unpkg.com/@primer/css/dist/primer.css' rel='stylesheet'></head><body><details class='details-overlay details-reset position-relative'>  <summary role='button' type='button' class='btn '>    Choose an option</summary>  <details-menu role='menu' class='SelectMenu '>    <div class='SelectMenu-modal '>        <header class='SelectMenu-header '>          <h3 class='SelectMenu-title '>            My menu</h3></header>      <div class='SelectMenu-list '>                    <button role='menuitemcheckbox' aria-checked='true' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 1</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 2</button>          <button role='menuitemcheckbox' type='button' class='btn SelectMenu-item '>              <svg class='octicon octicon-check SelectMenu-icon SelectMenu-icon--check' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z'></path></svg>            Item 3</button></div></div></details-menu></details></body></html>"></iframe>

```erb
<%= render Primer::SelectMenuComponent.new(details_overlay: :default, reset_details: true, position: :relative, menu_tag: :"details-menu") do |component| %>
  <%= component.slot(:summary) do %>
    Choose an option
  <% end %>
  <%= component.slot(:header) do %>
    My menu
  <% end %>
  <%= component.slot(:item, selected: true) do %>
    Item 1
  <% end %>
  <%= component.slot(:item) do %>
    Item 2
  <% end %>
  <%= component.slot(:item) do %>
    Item 3
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `align_right` | `Boolean` | `false` | Align the whole menu to the right or not. |
| `loading` | `Boolean` | `false` | Whether the content will be a loading message. |
| `blankslate` | `Boolean` | `false` | Whether to style the content as a blankslate, to represent there is no content. |
| `list_border` | `Symbol` | `:all` | What kind of border to have around the list element. One of `:all`, `:omit_top`, or `:none`. |
| `message` | `String` | `nil` | A message shown above the contents. |
| `list_role` | `String` | `nil` | Optional `role` attribute for the list element. |
| `overlay` | `Symbol` | N/A | options are `:none`, `:default`, and `:dark`. Dictates the type of overlay to render with. |
| `menu_tag` | `Symbol` | `:div` | HTML element type for the `.SelectMenu` tag; defaults to `:div`, could also use `:"details-menu"`. |
| `modal_classes` | `String` | `nil` | CSS classes to apply to the `.SelectMenu-modal` element. |
| `list_classes` | `String` | `nil` | CSS classes to apply to the `.SelectMenu-list` element. |
| `menu_classes` | `String` | `nil` | CSS classes to apply to the `.SelectMenu` element. |
| `message_classes` | `String` | `nil` | CSS classes to apply to the message element, if a message is included. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `summary` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `button` | `Boolean` | `true` | Whether the `summary` element should be styled as a button. |
| `button_type` | `Symbol` | `:default` | Only applies when `button`=`true`. One of `:default`, `:primary`, `:danger`, or `:outline`. |
| `variant` | `Symbol` | `:medium` | Only applies when `button`=`true`. One of `:small`, `:medium`, or `:large`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `closeable` | `Boolean` | `DEFAULT_CLOSEABLE` | Whether to include a close button in the header for closing the whole menu. |
| `title_tag` | `Symbol` | `DEFAULT_TITLE_TAG` | HTML element type for the `.SelectMenu-title` tag; defaults to `:h3`. |
| `title_classes` | `String` | `nil` | CSS classes to apply to the title element within the header. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments), including: `tag` (`Symbol`) - HTML element type for the header tag; defaults to `:header`. |

An optional header for the select menu.

### `item` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `selected` | `Boolean` | `DEFAULT_SELECTED` | Whether item is the currently active one. |
| `icon` | `Boolean` | `DEFAULT_ICON` | Whether or not to include a check Octicon when this item is selected. |
| `divider` | `Boolean, String, nil` | `nil` | Whether to show a divider after item. Pass `true` to show a simple line divider, or pass a String to show a divider with a title. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments), including: `tag` (`Symbol`) - HTML element type for the item tag; defaults to `:button`. `role` (`String`) - HTML role attribute for the item tag; defaults to `"menuitem"`. |

List items within the select menu.

### `filter` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `placeholder` | `String` | `DEFAULT_PLACEHOLDER` | The placeholder attribute for the input field. |
| `input_classes` | `String` | `"form-control"` | CSS classes to apply to the input element within the modal. |
| `aria_label` | `String` | `DEFAULT_PLACEHOLDER` | The aria-label attribute for the input field. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments), including: `tag` (`Symbol`) - HTML element type for the filter tag; defaults to `:form`. |

An optional filter bar for the select menu, to allow limiting how much of its contents
is shown at a time.

### `footer` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments), including: `tag` (`Symbol`) - HTML element type for the footer tag; defaults to `:footer`. |

An optional footer for the select menu.
