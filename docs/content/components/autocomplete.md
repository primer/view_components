---
title: AutoComplete
status: Alpha
source: https://github.com/primer/view_components/tree/main/app/components/primer/auto_complete_component.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-auto-complete-component
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use AutoComplete to populate input values from server search results.

## Examples

### Default

<Example src="<auto-complete src='/users/search' for='user-popup'>  <input name='username' type='text'></input>    <ul id='user-popup' class='autocomplete-results '></ul></auto-complete>" />

```erb
<%= render(Primer::AutoCompleteComponent.new(src: "/users/search", id: "user-popup")) do |c| %>
  <% c.input(type: :text, name: "username") %>
<% end %>
```

### With custom classes for the results

<Example src="<auto-complete src='/users/search' for='user-popup'>  <input name='username' type='text'></input>    <ul id='user-popup' class='autocomplete-results my-custom-class '></ul></auto-complete>" />

```erb
<%= render(Primer::AutoCompleteComponent.new(src: "/users/search", id: "user-popup")) do |c| %>
  <% c.input(type: :text, name: "username") %>
  <% c.results(classes: "my-custom-class") %>
<% end %>
```

### With Icon

<Example src="<auto-complete src='/users/search' for='user-popup'>  <input name='username' type='text'></input>  <svg class='octicon octicon-search' height='16' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true'><path fill-rule='evenodd' d='M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z'></path></svg>  <ul id='user-popup' class='autocomplete-results '></ul></auto-complete>" />

```erb
<%= render(Primer::AutoCompleteComponent.new(src: "/users/search", id: "user-popup")) do |c| %>
  <% c.input(type: :text, name: "username") %>
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

### `Input`

Required input used to search for results

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `type` | `Symbol` | N/A | One of `:text` and `:search`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

### `Icon`

Optional icon to be rendered before the input. Has the same arguments as <%= link_to_component(Primer::OcticonComponent) %>.

### `Results`

Customizable results list.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |
