---
title: ButtonGroup
componentId: button_group
status: Beta
source: https://github.com/primer/view_components/tree/main/app/components/primer/button_group.rb
storybook: https://primer.style/view-components/stories/?path=/story/primer-button-group
---

import Example from '../../src/@primer/gatsby-theme-doctocat/components/example'

<!-- Warning: AUTO-GENERATED file, do not edit. Add code comments to your Ruby instead <3 -->

Use `ButtonGroup` to render a series of buttons.

## Arguments

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `variant` | `Symbol` | `:medium` | One of `:large`, `:medium`, or `:small`. |
| `system_arguments` | `Hash` | N/A | [System arguments](/system-arguments) |

## Slots

### `Buttons`

Required list of buttons to be rendered.

| Name | Type | Default | Description |
| :- | :- | :- | :- |
| `kwargs` | `Hash` | N/A | The same arguments as [Button](/components/button) except for `variant` and `group_item`. |

## Examples

### Default

<Example src="<div data-view-component='true' class='BtnGroup'>    <button type='button' data-view-component='true' class='btn BtnGroup-item'>  Default</button>    <button type='button' data-view-component='true' class='btn-primary btn BtnGroup-item'>  Primary</button>    <button type='button' data-view-component='true' class='btn-danger btn BtnGroup-item'>  Danger</button>    <button type='button' data-view-component='true' class='btn-outline btn BtnGroup-item'>  Outline</button>    <button type='button' data-view-component='true' class='custom-class btn BtnGroup-item'>  Custom class</button></div>" />

```erb

<%= render(Primer::ButtonGroup.new) do |component| %>
  <% component.button { "Default" } %>
  <% component.button(scheme: :primary) { "Primary" } %>
  <% component.button(scheme: :danger) { "Danger" } %>
  <% component.button(scheme: :outline) { "Outline" } %>
  <% component.button(classes: "custom-class") { "Custom class" } %>
<% end %>
```

### Variants

<Example src="<div data-view-component='true' class='BtnGroup'>    <button type='button' data-view-component='true' class='btn-sm btn BtnGroup-item'>  Default</button>    <button type='button' data-view-component='true' class='btn-primary btn-sm btn BtnGroup-item'>  Primary</button>    <button type='button' data-view-component='true' class='btn-danger btn-sm btn BtnGroup-item'>  Danger</button>    <button type='button' data-view-component='true' class='btn-outline btn-sm btn BtnGroup-item'>  Outline</button></div><div data-view-component='true' class='BtnGroup'>    <button type='button' data-view-component='true' class='btn-large btn BtnGroup-item'>  Default</button>    <button type='button' data-view-component='true' class='btn-primary btn-large btn BtnGroup-item'>  Primary</button>    <button type='button' data-view-component='true' class='btn-danger btn-large btn BtnGroup-item'>  Danger</button>    <button type='button' data-view-component='true' class='btn-outline btn-large btn BtnGroup-item'>  Outline</button></div>" />

```erb

<%= render(Primer::ButtonGroup.new(variant: :small)) do |component| %>
  <% component.button { "Default" } %>
  <% component.button(scheme: :primary) { "Primary" } %>
  <% component.button(scheme: :danger) { "Danger" } %>
  <% component.button(scheme: :outline) { "Outline" } %>
<% end %>

<%= render(Primer::ButtonGroup.new(variant: :large)) do |component| %>
  <% component.button { "Default" } %>
  <% component.button(scheme: :primary) { "Primary" } %>
  <% component.button(scheme: :danger) { "Danger" } %>
  <% component.button(scheme: :outline) { "Outline" } %>
<% end %>
```
