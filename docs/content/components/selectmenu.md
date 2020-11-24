---
title: Select menu
---

Use select menus to list clickable choices, allow filtering between them, and highlight which ones are selected. See [Primer CSS documentation](https://primer.style/css/components/select-menu) for more details.

## Examples

Use a `DetailsComponent` to toggle the select menu:

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
      <%= menu_component.slot(:item, icon: "check") do %>
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

Or make the select menu the `details-menu` element itself:

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true) do |details_component| %>
  <% details_component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <% details_component.slot(:body, omit_wrapper: true) do %>
    <%= render Primer::SelectMenuComponent.new(tag: :"details-menu") do |menu_component| %>
      <%= menu_component.slot(:item) do %>
        Item 1
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 2
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 3
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

Include a button to close the menu:

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true, position: :relative) do |details_component| %>
  <% details_component.slot(:summary) do %>
    Choose an option
  <% end %>
  <% details_component.slot(:body) do %>
    <%= render Primer::SelectMenuComponent.new do |menu_component| %>
      <%= menu_component.slot(:header, close_button: true) do %>
        My menu
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 1
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 2
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 3
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

Include a filter field for filtering the modal contents:

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
      <%= menu_component.slot(:filter) %>
      <%= menu_component.slot(:item) do %>
        Item 1
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 2
      <% end %>
      <%= menu_component.slot(:item) do %>
        Item 3
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

Include tabs to have multiple lists of items:

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true) do |details_component| %>
  <% details_component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <% details_component.slot(:body, omit_wrapper: true) do %>
    <%= render Primer::SelectMenuComponent.new(tag: :"details-menu") do |menu_component| %>
      <%= menu_component.slot(:tab, selected: true) do %>
        Tab 1
      <% end >
      <%= menu_component.slot(:tab) do %>
        Tab 2
      <% end >
      <%= menu_component.slot(:item, tab: 1) do %>
        Item 1
      <% end %>
      <%= menu_component.slot(:item, tab: 1) do %>
        Item 2
      <% end %>
      <%= menu_component.slot(:item, tab: 2) do %>
        Item 3
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

Display a blankslate:

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true) do |details_component| %>
  <% details_component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <% details_component.slot(:body, omit_wrapper: true) do %>
    <%= render Primer::SelectMenuComponent.new(tag: :"details-menu", blankslate: true) do %>
      <h4>No results</h4>
      <p>There are no results to show.</p>
    <% end %>
  <% end %>
<% end %>
```

Display a loading message:

```erb
<%= render Primer::DetailsComponent.new(overlay: :default, reset: true) do |details_component| %>
  <% details_component.slot(:summary, title: "Pick an item") do %>
    Choose an option
    <span class="dropdown-caret"></span>
  <% end %>
  <% details_component.slot(:body, omit_wrapper: true) do %>
    <%= render Primer::SelectMenuComponent.new(tag: :"details-menu", loading: true) do |menu_component| %>
      <%= menu_component.slot(:footer) do %>
        Loading...
      <% end %>
      <%= render Primer::OcticonComponent(icon: "octoface", classes: "anim-pulse") %>
    <% end %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:div` | HTML element type for the `.SelectMenu` tag. |
| `align_right` | `Boolean` | `false` | Align the whole menu to the right or not. |
| `list_border` | `Symbol` | `:all` | What kind of border to have around the list element. One of `:all`, `:omit_top`, or `:none`. |
| `message` | `String` | N/A | A message shown above the contents. |
| `list_classes` | `String` | N/A | CSS classes to apply to the list element. |
| `list_role` | `String` | N/A | Optional `role` attribute for the list element. |
| `message_classes` | `String` | N/A | CSS classes to apply to the message element, if a message is included. |
| `loading` | `Boolean` | `false` | Whether the content will be a loading message. |
| `blankslate` | `Boolean` | `false` | Whether to style the content as a blankslate, to represent there is no content. |
| `tab_wrapper_classes` | `String` | N/A | CSS classes to apply to the containing tab `nav` element, if any tabs are added. |

### `item` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:button` | HTML element type for the item tag. |
| `tab` | `Integer` | `1` | Which tab this item should appear in. The first tab is 1. |
| `role` | `String` | `"menuitem"` | HTML role attribute for the item tag. |
| `icon` | `String` | `nil` | Octicon name for this item. Defaults to no icon. Set to a value like `"check"` to add an icon to this item. |
| `icon_classes` | `String` | N/A | CSS classes to apply to the icon. Only used if `icon` is not `nil`. |

### `tab` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `selected` | `Boolean` | `false` | Whether this tab is the one whose contents should be visible initially. |

### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:header` | HTML element type for the header tag. |
| `title_classes` | `String` | N/A | CSS classes to apply to the title element within the header. |
| `title_tag` | `Symbol` | `:h3` | HTML element type for the title tag. |
| `close_button` | `Boolean` | `false` | Whether to include a close button in the header for closing the whole menu. |
| `close_button_classes` | `String` | N/A | CSS classes to apply to the close button within the header. Only used if `close_button` = `true`. |

### `filter` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `placeholder` | `String` | `"Filter"` | The placeholder attribute for the input field. |
| `tag` | `Symbol` | `:form` | HTML element type for the filter tag. |
| `input_classes` | `String` | `"form-control"` | CSS classes to apply to the input element within the modal. |
| `aria-label` | `String` | `"Filter"` | The aria-label attribute for the input field. |

### `footer` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:footer` | HTML element type for the footer tag. |
