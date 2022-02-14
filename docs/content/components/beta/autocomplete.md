---
title: AutoComplete
componentId: auto_complete
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/beta/auto_complete.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-beta-auto-complete
---

import Example from '../../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
input field. This list is populated by server search results.

## Accessibility

Always set an accessible label to help the user interact with the component.

* `label_text` is required and visible by default.
* If you must use a non-visible label, set `is_label_visible` to `false`.
However, please note that a visible label should almost always
be used unless there is compelling reason not to. A placeholder is not a label.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `label_text` | `String` | N/A | The label of the input. |
| `src` | `String` | N/A | The route to query. |
| `input_id` | `String` | N/A | Id of the input element. |
| `list_id` | `String` | N/A | Id of the list element. |
| `is_label_visible` | `Boolean` | `true` | Controls if the label is visible. If `false`, screen reader only text will be added. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Input`

Optional slot to customize classes for the input field.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `type` | `Symbol` | N/A | One of `:search` and `:text`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Icon`

Optional icon to be rendered before the input. Has the same arguments as [Octicon](/components/octicon).

### `Results`

Customizable results list.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Examples

### Default

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-1' data-view-component='true' class='position-relative'>  <label for='fruits-input-1'>      Fruits  </label>  <input id='fruits-input-1' name='fruits-input-1' type='text' data-view-component='true' class='form-control' />  <ul id='fruits-popup-1' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-1", list_id: "fruits-popup-1", position: :relative)) %>
```

### With Non-Visible Label

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-2' data-view-component='true' class='position-relative'>  <label for='fruits-input-2'>      <span class='sr-only'>Fruits</span>  </label>  <input id='fruits-input-2' name='fruits-input-2' type='text' data-view-component='true' class='form-control' />  <ul id='fruits-popup-2' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-2", list_id: "fruits-popup-2", is_label_visible: false, position: :relative)) %>
```

### With Custom Classes for the Input

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-3' data-view-component='true' class='position-relative'>  <label for='fruits-input-3'>      Fruits  </label>  <input id='fruits-input-3' name='fruits-input-3' type='text' data-view-component='true' class='form-control custom-class' />  <ul id='fruits-popup-3' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-3", list_id: "fruits-popup-3", position: :relative)) do |c| %>
  <% c.input(classes: "custom-class") %>
<% end %>
```

### With Custom Classes for the Results

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-4' data-view-component='true' class='position-relative'>  <label for='fruits-input-4'>      Fruits  </label>  <input id='fruits-input-4' name='fruits-input-4' type='text' data-view-component='true' class='form-control' />  <ul id='fruits-popup-4' data-view-component='true' class='autocomplete-results custom-class'>    <li role='option' data-autocomplete-value='apple' aria-selected='true' data-view-component='true' class='autocomplete-item'>      Apple</li>    <li role='option' data-autocomplete-value='orange' data-view-component='true' class='autocomplete-item'>      Orange</li></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", input_id: "fruits-input-4", list_id: "fruits-popup-4", position: :relative)) do |c| %>
  <% c.results(classes: "custom-class") do %>
    <%= render(Primer::Beta::AutoComplete::Item.new(selected: true, value: "apple")) do |c| %>
      Apple
    <% end %>
    <%= render(Primer::Beta::AutoComplete::Item.new(value: "orange")) do |c| %>
      Orange
    <% end %>
  <% end %>
<% end %>
```

### With Icon

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-5' data-view-component='true' class='position-relative'>  <label for='fruits-input-5'>      Fruits      <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg>  </label>  <input id='fruits-input-5' name='fruits-input-5' type='text' data-view-component='true' class='form-control' />  <ul id='fruits-popup-5' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup-5", input_id: "fruits-input-5", position: :relative)) do |c| %>
  <% c.icon(icon: :search) %>
<% end %>
```

### With Icon and Non-Visible Label

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-5' data-view-component='true' class='position-relative'>  <label for='fruits-input-5'>      <span class='sr-only'>Fruits</span>      <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg>  </label>  <input id='fruits-input-5' name='fruits-input-5' type='text' data-view-component='true' class='form-control' />  <ul id='fruits-popup-5' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(label_text: "Fruits", src: "/auto_complete", list_id: "fruits-popup-5", input_id: "fruits-input-5", is_label_visible: false, position: :relative)) do |c| %>
  <% c.icon(icon: :search) %>
<% end %>
```
