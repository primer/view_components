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
hello
## Accessibility

Always set an accessible label to help the user interact with the component.

* Set the `label` slot to render a visible label. Alternatively, associate an existing visible text element
as a label by setting `aria-labelledby`.
* If you must use a non-visible label, set `:"aria-label"` on `AutoComplete` and Primer
will apply it to the correct elements. However, please note that a visible label should almost
always be used unless there is compelling reason not to. A placeholder is not a label.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `src` | `String` | N/A | The route to query. |
| `input_id` | `String` | N/A | Id of the input element. |
| `list_id` | `String` | N/A | Id of the list element. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Label`

Optionally render a visible label. See [Accessibility](#accessibility)

| Name | Type | Default | Description |
| :- | :- | :- | :- |
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

## Examples

### Default

<Example src="<label for='fruits-input-1' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-1' data-view-component='true' class='position-relative'>  <input id='fruits-input-1' name='fruits-input-1' type='text' data-view-component='true' class='form-control' />    <ul id='fruits-popup-1' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(src: "/auto_complete", input_id: "fruits-input-1", list_id: "fruits-popup-1", position: :relative)) do |c| %>
  <% c.label(classes:"").with_content("Fruits") %>
  <% c.input(type: :text) %>
<% end %>
```

### With `aria-label`

<Example src="<auto-complete src='/auto_complete' for='fruits-popup-2' data-view-component='true' class='position-relative'>  <input id='fruits-input-2' name='fruits-input-2' aria-label='Fruits' type='text' data-view-component='true' class='form-control' />    <ul id='fruits-popup-2' aria-label='Fruits' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new("aria-label": "Fruits", src: "/auto_complete", input_id: "fruits-input-2", list_id: "fruits-popup-2", position: :relative)) do |c| %>
  <% c.input(type: :text) %>
<% end %>
```

### With `aria-labelledby`

<Example src="<h2 id='search-1' data-view-component='true'>Search</h2><auto-complete src='/auto_complete' for='fruits-popup-2' data-view-component='true' class='position-relative'>  <input id='fruits-input-3' name='fruits-input-3' aria-labelledby='search-1' type='text' data-view-component='true' class='form-control' />    <ul id='fruits-popup-2' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::HeadingComponent.new(tag: :h2, id: "search-1")) { "Search" } %>
<%= render(Primer::Beta::AutoComplete.new(src: "/auto_complete", input_id: "fruits-input-3", list_id: "fruits-popup-2", position: :relative)) do |c| %>
  <% c.input("aria-labelledby": "search-1") %>
<% end %>
```

### With custom classes for the results

<Example src="<label for='fruits-input-4' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-3' data-view-component='true' class='position-relative'>  <input id='fruits-input-4' name='fruits-input-4' type='text' data-view-component='true' class='form-control' />    <ul id='fruits-popup-3' data-view-component='true' class='autocomplete-results custom-class'>    <li role='option' data-autocomplete-value='apple' aria-selected='true' data-view-component='true' class='autocomplete-item'>      Apple</li>    <li role='option' data-autocomplete-value='orange' data-view-component='true' class='autocomplete-item'>      Orange</li></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(src: "/auto_complete", input_id: "fruits-input-4", list_id: "fruits-popup-3", position: :relative)) do |c| %>
  <% c.label(classes:"").with_content("Fruits") %>
  <% c.input(type: :text) %>
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

<Example src="<label for='fruits-input-4' data-view-component='true'>Fruits</label><auto-complete src='/auto_complete' for='fruits-popup-4' data-view-component='true' class='position-relative'>  <input id='fruits-input-4' name='fruits-input-4' type='text' data-view-component='true' class='form-control' />  <svg aria-hidden='true' height='16' viewBox='0 0 16 16' version='1.1' width='16' data-view-component='true' class='octicon octicon-search'>    <path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg>  <ul id='fruits-popup-4' data-view-component='true' class='autocomplete-results'></ul></auto-complete>" />

```erb
<%= render(Primer::Beta::AutoComplete.new(src: "/auto_complete", list_id: "fruits-popup-4", input_id: "fruits-input-4", position: :relative)) do |c| %>
  <% c.label(classes:"").with_content("Fruits") %>
  <% c.input(type: :text) %>
  <% c.icon(icon: :search) %>
<% end %>
```
