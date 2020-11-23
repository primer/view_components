---
title: Select menu
---

Use select menus to list clickable choices, allow filtering between them, and highlight which ones are selected. See [Primer CSS documentation](https://primer.style/css/components/select-menu) for more details.

## Examples

Use a `DetailsComponent` to toggle the select menu.

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
      <%= menu_component.slot(:modal) do %>
        <button class="SelectMenu-item" role="menuitem">Item 1</button>
        <button class="SelectMenu-item" role="menuitem">Item 2</button>
        <button class="SelectMenu-item" role="menuitem">Item 3</button>
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
      <%= menu_component.slot(:modal) do %>
        <button class="SelectMenu-item" role="menuitem">Item 1</button>
        <button class="SelectMenu-item" role="menuitem">Item 2</button>
        <button class="SelectMenu-item" role="menuitem">Item 3</button>
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
      <%= menu_component.slot(:modal) do %>
        <button class="SelectMenu-item" role="menuitem">Item 1</button>
        <button class="SelectMenu-item" role="menuitem">Item 2</button>
        <button class="SelectMenu-item" role="menuitem">Item 3</button>
      <% end %>
    <% end %>
  <% end %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `align_right` | `Boolean` | `false` | Align the whole menu to the right or not. |

### `header` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `tag` | `Symbol` | `:header` | HTML element type for the header tag. |
| `title_classes` | `String` | N/A | CSS classes to apply to the title element within the header. |
| `title_tag` | `Symbol` | `:h3` | HTML element type for the title tag. |

### `modal` slot

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | [Style arguments](/style-arguments) |
| `border` | `Symbol` | `:all` | What kind of border to have around the modal. One of `:all`, `:omit_top`, or `:none`. |
| `message` | `String` | N/A | A message shown above the modal contents. |
| `list_classes` | `String` | N/A | CSS classes to apply to the list element within the modal. |
| `message_classes` | `String` | N/A | CSS classes to apply to the message element within the modal, if a message is included. |

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
