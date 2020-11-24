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
      <%= menu_component.slot(:header) do %>
        My menu
      <% end %>
      <%= menu_component.slot(:close_button) do %>
        <%= render Primer::OcticonComponent.new(icon: "x") %>
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

### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:header` | HTML element type for the header tag. |
| `title_classes` | `String` | N/A | CSS classes to apply to the title element within the header. |
| `title_tag` | `Symbol` | `:h3` | HTML element type for the title tag. |

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

### `close_button` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
