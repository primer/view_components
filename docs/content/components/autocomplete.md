---
title: AutoComplete
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/auto_complete.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-auto-complete-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'
import RequiresJSFlash from '../../src/@primer/gatsby-theme-doctocat/components/requires-js-flash'

<RequiresJSFlash />

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `AutoComplete` to provide a user with a list of selectable suggestions that appear when they type into the
input field. This list is populated by server search results.

## Accessibility

Always provide an accessible label to help the user interact with the input element and listbox popup.

To show a visible label, set the `label` slot. The`for` attribute must be set to the `id` of
`input` in order for the `<label>` to be properly linked.

If you do not wish to provide a visible label, you must set an `aria-label` attribute. You may set
`:"aria-label"` directly on `AutoComplete` instead of the slots and Primer will apply it to the correct elements.

## Examples

### Default

<Example src="<label for='example-input' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-1' data-view-component='true' class='position-relative'>  <input id='example-input' name='input' type='text' data-view-component='true' class='form-control'></input>    <ul id='fruits-popup-1' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-1", position: :relative)) do |c| %>
  <% c.label(for: "example-input").with_content("Fruits") %>
  <% c.input(id: "example-input", type: :text, name: "input") %>
<% end %>
```

### With `aria-label`

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-2' data-view-component='true' class='position-relative'>  <input name='input' aria-label='Fruits' type='text' data-view-component='true' class='form-control'></input>    <ul id='fruits-popup-2' aria-label='Fruits' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::AutoComplete.new("aria-label": "Fruits", src: "/auto_complete", id: "fruits-popup-2", position: :relative)) do |c| %>
  <% c.input(type: :text, name: "input") %>
<% end %>
```

### With custom classes for the results

<Example src="<label for='example-input-2' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-3' data-view-component='true' class='position-relative'>  <input id='example-input-2' name='input' type='text' data-view-component='true' class='form-control'></input>    <ul id='fruits-popup-3' data-view-component='true' class='autocomplete-results custom-class'>    <li role='option' data-autocomplete-value='apple' aria-selected='true' data-view-component='true' class='autocomplete-item'>      Apple</li>    <li role='option' data-autocomplete-value='orange' data-view-component='true' class='autocomplete-item'>      Orange</li></ul></auto-complete>" />

```erb
<%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-3", position: :relative)) do |c| %>
  <% c.label(for: "example-input-2").with_content("Fruits") %>
  <% c.input(id: 'example-input-2', type: :text, name: "input") %>
  <% c.results(classes: "custom-class") do %>
    <%= render(Primer::AutoComplete::Item.new(selected: true, value: "apple")) do |c| %>
      Apple
    <% end %>
    <%= render(Primer::AutoComplete::Item.new(value: "orange")) do |c| %>
      Orange
    <% end %>
  <% end %>
<% end %>
```

### With Icon

<Example src="<label for='example-input-3' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-4' data-view-component='true' class='position-relative'>  <input id='example-input-3' name='input' type='text' data-view-component='true' class='form-control'></input>  <svg aria-hidden='true' viewBox='0 0 16 16' version='1.1' data-view-component='true' height='16' width='16' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg>  <ul id='fruits-popup-4' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::AutoComplete.new(src: "/auto_complete", id: "fruits-popup-4", position: :relative)) do |c| %>
  <% c.label(for: "example-input-3").with_content("Fruits") %>
  <% c.input(id: "example-input-3", name: "input", ) %>
  <% c.icon(icon: :search) %>
<% end %>
```

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The route to query. |
| `id` | `String` | N/A | Id of the list element. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Label`

Optionally render a visible label. See [Accessibility](#system-arguments)

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `for` | `Symbol` | N/A | id of input |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Input`

Required input used to search for results

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
